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
export const RDB_NAME = { dbName: 'taskInfo.db' }; // db name
/** day info table */
export const DAY_INFO = {
    tableName: 'dayInfo',
    columns: ['date', 'targetTaskNum', 'finTaskNum']
};
/** global info table */
export const GLOBAL_INFO = {
    tableName: 'globalInfo',
    columns: ['id', 'firstDate', 'lastDate', 'checkInDays', 'achievements']
};
/** task info table */
export const TASK_INFO = {
    tableName: 'taskInfo',
    columns: [
        'id',
        'date',
        'taskID',
        'targetValue',
        'isAlarm',
        'startTime',
        'endTime',
        'frequency',
        'isDone',
        'finValue',
        'isOpen'
    ],
};
/** form info table */
export const FORM_INFO = {
    tableName: 'formInfo',
    columns: ['id', 'formId', 'formName', 'formDimension']
};
// TaskNum
export const TASK_NUM = 6;
// THOUSANDTH
export const THOUSANDTH_15 = '1.5%'; // ‘1.5%’
export const THOUSANDTH_12 = '2.2%'; // ‘2.2%’
export const THOUSANDTH_33 = '3.3%'; // ‘3.3%’
export const THOUSANDTH_50 = '5%'; // ‘5%’
export const THOUSANDTH_66 = '6.6%'; // ‘6.6%’
export const THOUSANDTH_80 = '8%'; // ‘8%’
export const THOUSANDTH_100 = '10%'; // ‘10%’
export const THOUSANDTH_120 = '12%'; // ‘12%’
export const THOUSANDTH_160 = '16%'; // ‘16%’
export const THOUSANDTH_400 = '40%'; // ‘40%’
export const THOUSANDTH_420 = '42%'; // ‘42%’
export const THOUSANDTH_500 = '50%'; // ‘50%’
export const THOUSANDTH_560 = '56%'; // ‘56%’
export const THOUSANDTH_800 = '80%'; // ‘80%’
export const THOUSANDTH_830 = '83%'; // ‘83%’
export const THOUSANDTH_880 = '88%'; // ‘88%’
export const THOUSANDTH_900 = '90%'; // ‘90%’
export const THOUSANDTH_940 = '94%'; // ‘90%’
export const THOUSANDTH_1000 = '100%'; // ‘100%’
export const DEFAULT_2 = 2;
export const DEFAULT_6 = 6;
export const DEFAULT_8 = 8;
export const DEFAULT_12 = 12;
export const DEFAULT_10 = 10;
export const DEFAULT_16 = 16;
export const DEFAULT_18 = 18;
export const DEFAULT_20 = 20;
export const DEFAULT_24 = 24;
export const DEFAULT_28 = 28;
export const DEFAULT_32 = 32;
export const DEFAULT_48 = 48;
export const DEFAULT_56 = 56;
export const DEFAULT_60 = 60;
export const DEFAULT_100 = 100;
export const DEFAULT_180 = 180;
// fontWeight
export const FONT_WEIGHT_400 = 400;
export const FONT_WEIGHT_500 = 500;
export const FONT_WEIGHT_700 = 700;
export const FONT_WEIGHT_900 = 900;
// opacity
export const OPACITY_4 = 0.4;
export const OPACITY_6 = 0.6;
// radius
export const BORDER_RADIUS_PERCENT_50 = '50%';
// duration
export const AD_DURATION = 5; // 5s
export const LAUNCHER_DELAY_TIME = 2000; // 2000ms
export const DURATION_1000 = 1000; // 1000ms
export const DURATION_800 = 800; // 700ms
export const DURATION_100 = 100; // 100ms
// list space
export const LIST_ITEM_SPACE = 2;
export const SPACE_4 = 4;
// navigation title
export const ADD_TASK_TITLE = '添加任务';
export const EDIT_TASK_TITLE = '编辑任务';
// prompt message
export const SETTING_FINISHED_MESSAGE = '设置完成！！！';
export const SETTING_FINISH_FAILED_MESSAGE = '网络连接错误';
export const CHOOSE_TIME_OUT_RANGE = '选择时间超出范围';
export const NICK_NAME = 'JoIin';
export const SIGNATURE = '这是一条简短地个人签';
export const HOME_BTN_Z = 2;
// time range
export const DEFAULT_TIME = '08:00';
export const GET_UP_TIME_RANGE = '(06:00 - 09:00)';
export const SLEEP_TIME_RANGE = '(20:00 - 23:00)';
export const GET_UP_EARLY_TIME = '06:00';
export const GET_UP_LATE_TIME = '09:00';
export const SLEEP_EARLY_TIME = '20:00';
export const SLEEP_LATE_TIME = '23:00';
// frequency Dialog
export const EVERYDAY = '每天';
export const NO_LENGTH = 0;
export const INIT_WEEK_IDS = '1, 2, 3, 4, 5, 6, 7';
// unit
export const PER_DAY = '/ 天';
// global data key
export const GLOBAL_KEY = 'global';
// RemindContent
export const GET_UP_TASK_NAME = '早起';
export const DRINK_TASK_NAME = '喝水';
export const EAT_APPLE_TASK_NAME = '吃苹果';
export const SMILE_TASK_NAME = '每日微笑';
export const BRUSH_TEETH_TASK_NAME = '每日刷牙';
export const SLEEP_TASK_NAME = '早睡';
export const GET_UP_CONTENT = '该早起啦';
export const DRINK_CONTENT = '该喝水啦';
export const EAT_APPLE_CONTENT = '该吃苹果啦';
export const SMILE_CONTENT = '请保持微笑';
export const BRUSH_TEETH_CONTENT = '每日刷牙';
export const SLEEP_CONTENT = '早睡';
export const H_STORE = 'healthAppStore';
export const REMINDER_AGENT_TAG = 'reminderAgent';
export const PACKAGE_NAME = 'com.example.healthy_life';
export const ENTRY_ABILITY = 'EntryAbility';
// offset
export const ZERO = 0;
export const MINUS_20 = -20;
export const HAS_NO_INDEX = -1;
export const OFFSET_24 = -24;
// targetSetting Range
export const DRINK_STEP = 25;
export const DRINK_MAX_RANGE = 500;
export const TIMES_50 = 50;
export const TIMES_100 = 100;
export const EAT_APPLE_RANGE = 100;
// letter spacing
export const LETTER_1 = 0.1;
export const LETTER_34 = 3.4;
// achievement
export const ACHIEVE_CARD_IMG_HEIGHT = 88;
export const ACHIEVE_CARD_TOP = 38;
export const ACHIEVE_CARD_BOTTOM = 10;
export const ACHIEVE_SPLIT_RATIO = 1 / 3;
export const ACHIEVE_TITLE_BAR_LEFT = 20;
export const ACHIEVE_TITLE_BAR_TOP = 15;
export const FULL_WIDTH = '100%';
export const FULL_HEIGHT = '100%';
export const WEEK_DAY_NUM = 7; // number days of one week
export const WEEK_DAY_TIME = WEEK_DAY_NUM * 24 * 60 * 60 * 1000;
export var TaskType;
(function (TaskType) {
    TaskType["Getup"] = "getup";
    TaskType["Drink"] = "drink";
    TaskType["Apple"] = "apple";
    TaskType["Smile"] = "smile";
    TaskType["Clean"] = "clean";
    TaskType["Sleep"] = "sleep";
})(TaskType || (TaskType = {}));
export var Unit;
(function (Unit) {
    Unit["Liter"] = "L";
    Unit["Pcs"] = "\u4E2A";
    Unit["Times"] = "\u6B21";
    Unit["Empty"] = "";
})(Unit || (Unit = {}));
// Card Constants
export const TAG = "UpdateFormUtils";
export const FORM_PARAM_IDENTITY_KEY = "ohos.extra.param.key.form_identity";
export const FORM_PARAM_DIMENSION_KEY = "ohos.extra.param.key.form_dimension";
export const FORM_PARAM_NAME_KEY = "ohos.extra.param.key.form_name";
export const DEFAULT_DIMENSION_2X2 = 2;
export const DEFAULT_DIMENSION_2X4 = 3;
export const WIDGET_NAME_AGENCY = "agency";
export const WIDGET_NAME_PROGRESS = "progress";
//# sourceMappingURL=CommonConstants.js.map