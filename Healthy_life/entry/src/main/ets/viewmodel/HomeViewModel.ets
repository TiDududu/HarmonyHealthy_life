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

import { DEFAULT_100 ,DEFAULT_200 ,DEFAULT_300 } from '../common/constants/CommonConstants';
import { isReachNewAchievement,isReachNewAchievement_single, ACHIEVEMENT_LEVEL_KEY, ACHIEVEMENT_LEVEL_KEY_SINGLE } from '../model/AchieveModel';
import { TaskMapById, ITaskItem, ACHIEVEMENT_LEVEL_LIST,ACHIEVEMENT_LEVEL_LIST_SINGLE } from '../model/TaskInitList';
import TaskInfo from '../common/bean/TaskInfo';
import DayInfo from '../common/bean/DayInfo';
import { dateToStr, monthFormat, weekDateFormat } from '../common/utils/Utils';
import { WeekDateModel, initializeOnStartUp, getPreviousWeek, WEEK_DAY_NUM } from '../model/WeekCalendarModel';
import { initializeOnStartUp_Month,getPreviousMonth,getNextMonth } from '../model/MonthCalendarModel'
import DatabaseApi from '../model/DatabaseModel';
import TaskInfoTableApi from '../common/database/tables/TaskInfoApi';
import DayInfoApi from '../common/database/tables/DayInfoApi';
import GlobalInfoApi from '../common/database/tables/GlobalInfoApi';
import  TaskInfoApi from '../common/database/tables/TaskInfoApi';
import Logger from '../common/utils/Logger';

@Observed
export class HomeStore {
  public currentDate: Date;
  public dateArr: Array<WeekDateModel> = []; // data source list
  public weekArr: Array<Array<WeekDateModel>>=[];
  public selectedDay: number; // selected day of on week
  public showDate: number;
  public dateTitle: string;
  public monthTitle: string;
  public month: number;
  public selectedDayInfo: WeekDateModel; // task info on selected day

  constructor(currentDate: Date) {
    this.currentDate = currentDate;
    this.showDate = currentDate.getTime();
    this.dateTitle = weekDateFormat(currentDate.getTime());
    this.monthTitle = monthFormat(currentDate.getTime());
    this.month=currentDate.getMonth();
    this.selectedDay = (new Date().getDay() + WEEK_DAY_NUM - 1) % WEEK_DAY_NUM;
  }

  public initData() {
    let [initArr, dateArr] = initializeOnStartUp(this.currentDate);
    let [initArrMonth,dateArrMonth]=initializeOnStartUp_Month(this.currentDate);
    this.dateArr = initArr;
    this.weekArr=initArrMonth;
    Logger.info('this.currentDate', this.currentDate.toDateString());
    Logger.info('initWeekData dateArr', JSON.stringify(dateArr))
    // get data form db
    DatabaseApi.query(dateToStr(new Date()), (taskList, dayInfo) => {
      Logger.info('Current Day Task Info: ', JSON.stringify(taskList));
      DayInfoApi.queryList(dateArr, (res: DayInfo[]) => {
        let tempList = res.concat(dayInfo);
        Logger.info('initDayInfoList: ', JSON.stringify(res));
        for (let i = 0; i < this.dateArr.length; i++) {
          let tempDayInfo = tempList.find((item) => item.date == this.dateArr[i].dateStr) || {
            date: this.dateArr[i].dateStr,
            finTaskNum: 0,
            targetTaskNum: 0
          };
          initArr[i].dayInfo = tempDayInfo;
          if (this.dateArr[i].dateStr == dateToStr(new Date(this.showDate))) {
            // get tasks of showDate
            initArr[i].taskList = taskList;
          }
        }
        this.dateArr = initArr;

        for(let j=0;j<dateArrMonth.length;j++){
          DayInfoApi.queryList(dateArrMonth[j], (res: DayInfo[]) => {
            let tempList = res.concat(dayInfo);
            Logger.info('initDayInfoList: ', JSON.stringify(res));
            for (let i = 0; i < this.weekArr[j].length; i++) {
              let tempDayInfo = tempList.find((item) => item.date == this.weekArr[j][i].dateStr) || {
                date: this.weekArr[j][i].dateStr,
                finTaskNum: 0,
                targetTaskNum: 0
              };
              this.weekArr[j][i].dayInfo = tempDayInfo;
              if (this.weekArr[j][i].dateStr == dateToStr(new Date(this.showDate))) {
                // get tasks of showDate
                this.weekArr[j][i].taskList = taskList;
              }
            }
          })
        }
        setTimeout(() => {
          this.setSelectedShowDate(this.showDate);
        }, 0)
      })
    });
  }

  public getPreWeekData(date: Date, callback: Function) {
    let [initArr, dateArr] = getPreviousWeek(date);
    // get data form db
    DayInfoApi.queryList(dateArr, (res: DayInfo[]) => {
      Logger.info('getPreWeekData->DayInfoList: ', JSON.stringify(res));
      if (res.length > 0) {
        for (let i = 0; i < initArr.length; i++) {
          let dayInfo = res.find((item) => item.date == initArr[i].dateStr) || null;
          initArr[i].dayInfo = dayInfo;
        }
      }
      this.dateArr = initArr.concat(...this.dateArr);
    })
    callback();
  }

  public getPreMonthData(date: Date, callback: Function) {
    let [initArr, dateArr] = getPreviousMonth(date);
    // get data form db
    this.weekArr=initArr;
    for (let j=0;j<this.weekArr.length;j++) {
      DayInfoApi.queryList(dateArr[j], (res: DayInfo[]) => {
        Logger.info('getPreMonthData->DayInfoList: ', JSON.stringify(res));
        if (res.length > 0) {
          for (let i = 0; i < this.weekArr[j].length; i++) {
            let dayInfo = res.find((item) => item.date == this.weekArr[j][i].dateStr) || null;
            this.weekArr[j][i].dayInfo = dayInfo;
          }
          this.weekArr.push(initArr[j]);
        }
        //this.weekArr.push(initArr[j]);
      })
    }
    callback();
  }

  public getNextMonthData(date: Date, callback: Function) {
    let [initArr, dateArr] = getNextMonth(date);
    // get data form db
    this.weekArr=initArr;
    for (let j=0;j<this.weekArr.length;j++) {
      DayInfoApi.queryList(dateArr[j], (res: DayInfo[]) => {
        Logger.info('getPreMonthData->DayInfoList: ', JSON.stringify(res));
        if (res.length > 0) {
          for (let i = 0; i < this.weekArr[j].length; i++) {
            let dayInfo = res.find((item) => item.date == this.weekArr[j][i].dateStr) || null;
            this.weekArr[j][i].dayInfo = dayInfo;
          }
        }
        //this.weekArr.push(initArr[j]);
      })
    }
    callback();
  }

  // check is current day
  public checkCurrentDay(): boolean {
    return dateToStr(new Date()) === this.selectedDayInfo?.dateStr;
  }

  public updateSelectedDayInfo(selectedDayInfo: WeekDateModel) {
    Logger.debug('updateSelectedDayInfo', JSON.stringify(selectedDayInfo));
    if (selectedDayInfo.taskList?.length === 0) { //获取该日期的任务列表
      // get data form db
      TaskInfoTableApi.query(selectedDayInfo.dateStr, true, (res) => {
        Logger.info('Selected TaskInfoList: ', JSON.stringify(res));
        selectedDayInfo.taskList = res;
        this.dateArr = this.dateArr.map((item: WeekDateModel) =>
          item.dateStr == selectedDayInfo.dateStr ? { ...item, taskList: res } : item);
        this.selectedDayInfo = { ...selectedDayInfo };
      });
    } else {
      this.selectedDayInfo = { ...selectedDayInfo };
    }
    Logger.info("selectedDayTaskInfo: ", JSON.stringify(selectedDayInfo.taskList));
  }

  public updateTaskInfoList(editedTaskInfo: ITaskItem) {
    if (editedTaskInfo?.taskID) {
      // edited task
      const {taskID, targetValue, isAlarm, frequency, startTime, endTime, isOpen } = editedTaskInfo;
      let finValue;

      if (taskID == 1 || taskID == 6) {
        finValue = '--';
      } else if (taskID >= 2 && taskID <= 5) {
        finValue = '0';
      } else if(taskID == 7) {
        finValue = '0';
      } else {
        finValue = 'Invalid taskID'; // You may want to handle invalid taskID in a way that suits your program.
      }


      let task: TaskInfo = {
        isOpen,
        id: 0,
        date: dateToStr(new Date()),
        isDone: false,
        taskID,
        targetValue,
        isAlarm,
        frequency,
        startTime,
        endTime,
        finValue
      }
      this.dateArr = this.dateArr.map((item: WeekDateModel) => {
        if (task.date == item.dateStr) {
          Logger.info('item', JSON.stringify(item));
          let taskList: TaskInfo[] = item.taskList;
          const dayInfo: DayInfo = item.dayInfo;
          if (editedTaskInfo.isOpen) {
            // add task
            taskList = taskList.filter((taskItem) => taskItem.taskID != taskID)
              .concat(task)
              .sort((a, b) => a.taskID - b.taskID);
            let count: number = 0;
            taskList.forEach((taskItem: TaskInfo) => {
              if (taskItem.isDone) {
                count++;
              }
            });
            if (count > dayInfo.finTaskNum) {
              dayInfo.finTaskNum = count;
            }
          } else {
            // delete task
            let taskIndex = taskList.findIndex((taskItem) => taskItem.taskID == taskID);
            Logger.info('taskList[taskIndex]', JSON.stringify(taskList[taskIndex]));
            if (taskList[taskIndex]?.isDone) {
              dayInfo.finTaskNum -= 1;
            }
            taskList = taskList.filter((taskItem) => taskItem.taskID != taskID);
          }
          dayInfo.targetTaskNum = taskList.length;
          if (dayInfo.finTaskNum > dayInfo.targetTaskNum) {
            dayInfo.finTaskNum = dayInfo.targetTaskNum;
          }
          DayInfoApi.updateData(dayInfo, () => {
          });
          Logger.debug("tempDayInfo", JSON.stringify(dayInfo));
          let currentDayInfo = { ...item, taskList, dayInfo };
          if (this.checkCurrentDay()) {
            this.selectedDayInfo = currentDayInfo;
          }
          return currentDayInfo;
        }
        return item;
      }).slice(0);
    }
  }

  public setSelectedShowDate(showDateTime: number) {
    if (showDateTime > new Date().getTime()) {
      return;
    }
    this.showDate = showDateTime;
    this.dateTitle = weekDateFormat(this.showDate);
    this.monthTitle = monthFormat(this.showDate);
    let date=new Date(this.showDate);
    this.month=date.getMonth();
    let selectedInfo = this.dateArr.find((item: WeekDateModel) => item.dateStr == dateToStr(new Date(showDateTime)));
    if (selectedInfo) {
      this.updateSelectedDayInfo({ ...selectedInfo });
    }
    Logger.info('dateTitle', this.dateTitle);
    Logger.info('monthTitle', this.monthTitle);
  }

  public getDonePercent(): string {
    let dayInfo = this.selectedDayInfo?.dayInfo;
    Logger.debug("dayInfo", JSON.stringify(dayInfo));
    if (dayInfo && (dayInfo?.finTaskNum || 0) > 0) {
      // if (dayInfo.finTaskNum > dayInfo.targetTaskNum) {
      //   return `${DEFAULT_100}`;
      // }
      return `${DEFAULT_200}` ;
       // return `${Math.ceil(dayInfo.finTaskNum / dayInfo.targetTaskNum * DEFAULT_100)}`;
    }
    return '0';
  }

  public getTaskListOfDay(): TaskInfo[] {
    Logger.info('getTaskListOfDay', JSON.stringify(this.selectedDayInfo));
    if (this.selectedDayInfo && this.selectedDayInfo.taskList.length > 0) {
      return this.selectedDayInfo.taskList;
    }
    return [];
  }

  public async taskClock(taskInfo: TaskInfo) {
    let taskItem = await this.updateTask(taskInfo);
    let dateStr = this.selectedDayInfo?.dateStr;
    if (!taskItem) {
      return Promise.resolve({
        achievementLevel: 0,
         achievementLevel_single:0,
        showAchievement: false,
        showAchievement_single: false
      });
    }

    this.selectedDayInfo.taskList = this.selectedDayInfo.taskList.map((item) => {
      return item.taskID == taskItem?.taskID ? taskItem : item;
    });
    let achievementLevel;
    let achievementLevel_single;
    if (taskItem.isDone) {
      let dayInfo = await this.updateDayInfo();
      if (dayInfo && dayInfo?.finTaskNum === dayInfo?.targetTaskNum) {
        achievementLevel = await this.updateAchievement(this.selectedDayInfo.dayInfo);
      }
      if (dayInfo && dayInfo?.finTaskNum >= dayInfo?.targetTaskNum){
        achievementLevel_single = await this.updateAchievement_single(this.selectedDayInfo.dayInfo);
      }
    }

    this.dateArr = this.dateArr.map((item: WeekDateModel) => dateStr == item.dateStr ? this.selectedDayInfo : item);
    Logger.info('achievementLevel', `${achievementLevel}`);
    Logger.info('achievementLevel_single', `${achievementLevel_single}`);

    return Promise.resolve({
      achievementLevel: achievementLevel,
      achievementLevel_single : achievementLevel_single,
      showAchievement: ACHIEVEMENT_LEVEL_LIST.includes(achievementLevel),
      showAchievement_single: ACHIEVEMENT_LEVEL_LIST_SINGLE.includes(achievementLevel_single)
    });
  }

  updateTask(task: TaskInfo): Promise<TaskInfo> {
    return new Promise((resolve, reject) => {
      let {taskID, targetValue, finValue} = task;
      let updateTask = Object.assign({}, task);
      let step = TaskMapById[taskID].step;
      let hasExceed = updateTask.isDone;
      if (step === 0) {
        updateTask.isDone = true;
        updateTask.finValue = targetValue;
      } else {
        let value = Number(finValue) + step;
        updateTask.isDone = updateTask.isDone || value >= Number(targetValue);
        // updateTask.finValue = updateTask.isDone ? targetValue : `${value}`;
        updateTask.finValue = `${value}`;
        Logger.info('finvalue after update' + updateTask.finValue);
      }
      TaskInfoTableApi.updateDataByDate(updateTask, (res) => {
        if (!res || hasExceed) {
          Logger.error('taskClock-updateTask', JSON.stringify(res));
          reject(res);
        }
        resolve(updateTask);
      })
    })
  }

  updateDayInfo(): Promise<DayInfo> {
    let dayInfo: DayInfo = this.selectedDayInfo.dayInfo;
    dayInfo.finTaskNum += 1;
    dayInfo.targetTaskNum = this.selectedDayInfo.taskList.length;
    return new Promise((resolve, reject) => {
      DayInfoApi.updateData(dayInfo, (res) => {
        if (!res) {
          Logger.error('taskClock-updateDayInfo', JSON.stringify(res));
          reject(res);
        }
        Logger.info('taskClock-updateDayInfo', JSON.stringify(dayInfo));
        // 同步界面数据
        this.selectedDayInfo = { ...this.selectedDayInfo, dayInfo };
        resolve(dayInfo);
      });
    });
  }

  updateAchievement(dayInfo: DayInfo): Promise<number> {
    Logger.debug('taskClock-updateAchievement', JSON.stringify(dayInfo));
    return new Promise((resolve, reject) => {
      let preDay = new Date();
      preDay.setDate(preDay.getDate() - 1);
      preDay = new Date(preDay);
      let preDayStr = dateToStr(preDay);
      Logger.info('taskClock-updateAchievement-1', `${preDayStr}`);
      DayInfoApi.query(preDayStr, (res) => {
        Logger.info('taskClock-updateAchievement-2', JSON.stringify(res));
        let isReset = res?.length === 0 || res?.targetTaskNum > res?.finTaskNum;
        GlobalInfoApi.query((res) => {
          Logger.info('taskClock-globalInfoApi', JSON.stringify(res));
          let achievementInfo = res;
            isReset ? (achievementInfo.checkInDays = 1) : (achievementInfo.checkInDays += 1);
          let isNewAchieve = isReachNewAchievement(achievementInfo);
          if (isNewAchieve) {
            AppStorage.SetOrCreate(ACHIEVEMENT_LEVEL_KEY, achievementInfo.checkInDays);
            achievementInfo.achievements = achievementInfo.achievements + ',' + achievementInfo.checkInDays;
          }
          //
          // //增加单项成就
          // let isNewAchieve_single = isReachNewAchievement_single(achievementInfo);
          // if (isNewAchieve_single) {
          //   AppStorage.SetOrCreate(ACHIEVEMENT_LEVEL_KEY_SINGLE, achievementInfo.checkInDays);
          //   achievementInfo.achievements = achievementInfo.achievements + ',' + achievementInfo.checkInDays;
          // }


          GlobalInfoApi.updateData(achievementInfo, (res) => {
            if (!res) {
              Logger.error('taskClock-updateAchievement', JSON.stringify(res));
              reject(res);
            }
            Logger.debug('taskClock-updateAchievement', JSON.stringify(achievementInfo));
              isNewAchieve ? resolve(achievementInfo.checkInDays) : resolve(0);
          });
        });
      })
    });
  }


  updateAchievement_single(dayInfo: DayInfo): Promise<number> {
    Logger.debug('taskClock-updateAchievement_single', JSON.stringify(dayInfo));
    return new Promise((resolve, reject) => {
      let preDay = new Date();
      preDay.setDate(preDay.getDate() - 1);
      preDay = new Date(preDay);
      let preDayStr = dateToStr(preDay);
      Logger.info('taskClock-updateAchievement_single-1', `${preDayStr}`);
      DayInfoApi.query(preDayStr, (res) => {
        Logger.info('taskClock-updateAchievement_single-2', JSON.stringify(res));
      //  let isReset = res?.length === 0 || res?.targetTaskNum > res?.finTaskNum;
        GlobalInfoApi.query((res) => {
          Logger.info('taskClock-globalInfoApi', JSON.stringify(res));
          let achievementInfo_single = res;
      //      isReset ? (achievementInfo.checkInDays = 1) : (achievementInfo.checkInDays += 1);

          let isNewAchieve_single = isReachNewAchievement_single(achievementInfo_single);

          let finish_time: number = 200;

          TaskInfoApi.query(preDayStr, true, (res) => {
            let taskInfo: TaskInfo = res;
           // finish_time = Number(taskInfo.finValue) / Number(taskInfo.targetValue) ;
          });


          if (isNewAchieve_single) {
            AppStorage.SetOrCreate(ACHIEVEMENT_LEVEL_KEY_SINGLE, finish_time);
            achievementInfo_single.achievements_single = achievementInfo_single.achievements_single + ',' + finish_time;
          }
          GlobalInfoApi.updateData(achievementInfo_single, (res) => {
            if (!res) {
              Logger.error('taskClock-updateAchievement_single', JSON.stringify(res));
              reject(res);
            }
            Logger.debug('taskClock-updateAchievement_single', JSON.stringify(achievementInfo_single));
              isNewAchieve_single ? resolve(finish_time) : resolve(0);
          });
        });
      })
    });
  }


}