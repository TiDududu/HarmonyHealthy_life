/*
 * Copyright (c) 2022 Huawei Device Co., Ltd.
 * Licensed under the Apache License,Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import { EVERYDAY, GLOBAL_KEY, DRINK_STEP, DRINK_MAX_RANGE, EAT_APPLE_RANGE, TIMES_100 } from '@bundle:com.example.healthy_life/entry/ets/common/constants/CommonConstants';
import Logger from '@bundle:com.example.healthy_life/entry/ets/common/utils/Logger';
import reminder from '@bundle:com.example.healthy_life/entry/ets/service/ReminderAgent';
import TaskInfoApi from '@bundle:com.example.healthy_life/entry/ets/common/database/tables/TaskInfoApi';
import { padTo2Digits } from '@bundle:com.example.healthy_life/entry/ets/common/utils/Utils';
import { oneWeek } from '@bundle:com.example.healthy_life/entry/ets/common/bean/TaskInfo';
import { TaskMapById, RemindContentMap } from '@bundle:com.example.healthy_life/entry/ets/model/TaskInitList';
const { publishReminder, cancelReminder, hasNotificationId } = reminder;
export const taskOriginData = Object.keys(TaskMapById).map(item => {
    return TaskMapById[item];
});
/**
 * @description Get all task status
 * @return object[] Database query results
 */
export const getAllTask = async () => {
    return new Promise((resolve) => {
        TaskInfoApi.query(GLOBAL_KEY, true, (res) => {
            if ((res === null || res === void 0 ? void 0 : res.length) === 0) {
                Logger.warn('queryTaskList', 'has no data!!');
                resolve(res !== null && res !== void 0 ? res : []);
            }
            resolve(res);
        });
    });
};
/**
 * @description Call notification capability
 * @param params {
 *  hour: Hour
 *  minute: Minute
 *  daysOfWeek: Frequency of a week
 *  title: Notice Title
 *  content: Contents of notice
 *  notificationId: Notification ID
 */
const useReminder = (params, context) => {
    try {
        publishReminder({
            hour: Number(params === null || params === void 0 ? void 0 : params.startTime.split(':')[0]),
            minute: Number(params === null || params === void 0 ? void 0 : params.startTime.split(':')[1]),
            daysOfWeek: params === null || params === void 0 ? void 0 : params.frequency.split(',').map(item => Number(item)),
            title: RemindContentMap[params === null || params === void 0 ? void 0 : params.taskID].title,
            content: RemindContentMap[params === null || params === void 0 ? void 0 : params.taskID].content,
            notificationId: params === null || params === void 0 ? void 0 : params.taskID,
        }, context);
    }
    catch (error) {
        Logger.error('publishReminder', JSON.stringify(error));
    }
};
/**
 * @description Call cancel notification capability
 * @param reminderId Notification ID
 */
const useCancelReminder = (reminderId, context) => {
    try {
        cancelReminder(reminderId, context);
    }
    catch (error) {
        Logger.error('cancelReminder', JSON.stringify(error));
    }
};
/**
 * @description Determine whether there is a notification
 * @param notificationId Notification ID
 */
const isHasNotificationId = (notificationId) => {
    return new Promise((resolve) => {
        resolve(hasNotificationId(notificationId));
    });
};
/**
 * @param params:TaskInfo
 */
export const addTask = (params, context) => {
    if (!params) {
        Logger.error('addTask', 'params is null!');
        return;
    }
    return new Promise((resolve, reject) => {
        Logger.info('TaskViewModel', 'addTask');
        if (params === null || params === void 0 ? void 0 : params.isOpen) {
            if (params === null || params === void 0 ? void 0 : params.isAlarm) {
                useReminder(params, context);
            }
            else {
                isHasNotificationId(params === null || params === void 0 ? void 0 : params.taskID).then(flag => {
                    if (flag) {
                        useCancelReminder(params.taskID, context);
                    }
                });
            }
        }
        else {
            isHasNotificationId(params === null || params === void 0 ? void 0 : params.taskID).then(flag => {
                if (flag) {
                    useCancelReminder(params.taskID, context);
                }
            });
        }
        TaskInfoApi.updateDataByDate(params, (flag) => {
            if (!flag) {
                Logger.error('insertTaskSetting', 'updateTaskSetting Error!');
                reject(flag);
            }
            resolve(flag);
        });
        TaskInfoApi.updateDataByDate(Object.assign(Object.assign({}, params), { date: new Date().toDateString(), isDone: true }), (flag) => {
            if (!flag) {
                Logger.error('insertTaskSetting', 'updateTaskSetting Error!');
                reject(flag);
            }
            resolve(flag);
        });
    });
};
/**
 * @description Used to initialize task list data from database data
 * @param taskInitList Task list initial data
 * @param taskInfoData Database query data
 */
export const taskIndexDataInit = (taskInitList, taskInfoData) => {
    const afterInitData = taskInitList.map((content) => {
        taskInfoData.forEach((item) => {
            if ((item === null || item === void 0 ? void 0 : item.taskID) === (content === null || content === void 0 ? void 0 : content.taskID)) {
                content.isOpen = item === null || item === void 0 ? void 0 : item.isOpen;
                content.targetValue = item === null || item === void 0 ? void 0 : item.targetValue;
                content.isAlarm = item === null || item === void 0 ? void 0 : item.isAlarm;
                content.startTime = item === null || item === void 0 ? void 0 : item.startTime;
                content.endTime = item === null || item === void 0 ? void 0 : item.endTime;
                content.frequency = item === null || item === void 0 ? void 0 : item.frequency;
            }
        });
        return content;
    });
    return afterInitData;
};
/**
 * @description format data as json string
 * @param params = {}
 */
export const formatParams = (params = {}) => {
    return JSON.stringify(params);
};
/**
 * @description Initialization frequency string
 * @param frequencyIdCollection
 * @return string Frequency string
 */
export const initFrequencyString = (frequencyIdCollection) => {
    if (frequencyIdCollection === '') {
        return EVERYDAY;
    }
    const frequencyIdArray = frequencyIdCollection.split(',').map(item => Number(item));
    const length = frequencyIdArray.length;
    if (length === 7) {
        return EVERYDAY;
    }
    const frequencyString = frequencyIdArray.reduce((pre, current) => {
        return pre + ' ' + oneWeek[current];
    }, '');
    return frequencyString;
};
/**
 * @description Returns the timestamp of today's selected time
 * @param currentTime
 * @return timestamp
 */
export function returnTimeStamp(currentTime) {
    const timeString = `${new Date().toDateString()} ${currentTime}`;
    return new Date(timeString).getTime();
}
/**
 * @description It is used for formatting time and displayed in the form of HH: mm
 * @param value
 */
export const formatTime = (value) => {
    return `${padTo2Digits(value === null || value === void 0 ? void 0 : value.hour)}:${padTo2Digits(value === null || value === void 0 ? void 0 : value.minute)}`;
};
/**
 * @description Range of generated drinking water 0.25 - 5 L
 * @return Array<string>
 */
export const createDrinkRange = () => {
    const drinkRangeArr = [];
    for (let i = DRINK_STEP; i <= DRINK_MAX_RANGE; i += DRINK_STEP) {
        drinkRangeArr.push(`${i / TIMES_100} L`);
    }
    return drinkRangeArr;
};
/**
 * @description Generate the range of eating apples 1 - 100
 * @return Array<string>
 */
export const createAppleRange = () => {
    const appleRangeArr = [];
    for (let i = 1; i <= EAT_APPLE_RANGE; i++) {
        appleRangeArr.push(`${i} 个`);
    }
    return appleRangeArr;
};
//# sourceMappingURL=TaskViewModel.js.map