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

import TaskInfo from '../common/bean/TaskInfo';
import {
  GET_UP_TASK_NAME,
  DRINK_TASK_NAME,
  EAT_APPLE_TASK_NAME,
  SMILE_TASK_NAME,
  BRUSH_TEETH_TASK_NAME,
  SLEEP_TASK_NAME,
  RUN_TASK_NAME,
  GET_UP_CONTENT,
  DRINK_CONTENT,
  EAT_APPLE_CONTENT,
  SMILE_CONTENT,
  BRUSH_TEETH_CONTENT,
  SLEEP_CONTENT,
  RUN_CONTENT
} from '../common/constants/CommonConstants';

export interface ITaskItem {
  taskID: number;
  taskName: Resource;
  isOpen: boolean;
  unit: string;
  icon: Resource;
  dialogBg: Resource;
  targetValue: string;
  isAlarm: boolean;
  startTime: string;
  endTime: string;
  frequency: string;
  isInit: boolean;
  step: number;
  frequencyIds: boolean[];
}

export interface TaskInitListType {
  [key: number]: ITaskItem;
}

export interface FrequencyContentType {
  id: number,
  label: string,
  isChecked: boolean
}

export const TaskList: TaskInfo[] = [
  {
    id: 0,
    taskID: 1,
    isOpen: true,
    date: '',
    targetValue: '7:00',
    isAlarm: true,
    startTime: '',
    endTime: ';',
    frequency: '',
    isDone: false,
    finValue: ''
  },
  {
    id: 1,
    taskID: 2,
    isOpen: true,
    date: '',
    targetValue: '1.5',
    isAlarm: true,
    startTime: '',
    endTime: ';',
    frequency: '',
    isDone: false,
    finValue: ''
  },
  {
    id: 2,
    taskID: 3,
    isOpen: true,
    date: '',
    targetValue: '3',
    startTime: '08: 00',
    endTime: '',
    isAlarm: true,
    frequency: '',
    isDone: false,
    finValue: ''
  },
  {
    id: 3,
    taskID: 4,
    isOpen: true,
    date: '',
    targetValue: '1',
    isAlarm: true,
    startTime: '',
    endTime: ';',
    frequency: '',
    isDone: false,
    finValue: ''
  },
  {
    id: 4,
    taskID: 5,
    isOpen: true,
    date: '',
    targetValue: '21:30',
    isAlarm: true,
    startTime: '',
    endTime: ';',
    frequency: '',
    isDone: false,
    finValue: ''
  },
  {
    id: 5,
    taskID: 6,
    isOpen: true,
    date: '',
    targetValue: '22:00',
    isAlarm: true,
    startTime: '',
    endTime: ';',
    frequency: '',
    isDone: false,
    finValue: ''
  },
  {
    id: 6,
    taskID: 7,
    isOpen: true,
    date: '',
    targetValue: '3',
    isAlarm: true,
    startTime: '08: 00',
    endTime: ';',
    frequency: '',
    isDone: false,
    finValue: ''
  }
]

export const AchievementMap = {
  '3_off': $r('app.media.ic_badge_3_off'),
  '3_on': $r('app.media.ic_badge_3_on'),
  '7_off': $r('app.media.ic_badge_7_off'),
  '7_on': $r('app.media.ic_badge_7_on'),
  '30_off': $r('app.media.ic_badge_30_off'),
  '30_on': $r('app.media.ic_badge_30_on'),
  '50_off': $r('app.media.ic_badge_50_off'),
  '50_on': $r('app.media.ic_badge_50_on'),
  '73_off': $r('app.media.ic_badge_73_off'),
  '73_on': $r('app.media.ic_badge_73_on'),
  '99_off': $r('app.media.ic_badge_99_off'),
  '99_on': $r('app.media.ic_badge_99_on'),
  'task1_off': $r('app.media.task1_off'),
  'task1_on': $r('app.media.task1_on'),
  'task2_off': $r('app.media.task2_off'),
  'task2_on': $r('app.media.task2_on'),
  'task3_off': $r('app.media.task3_off'),
  'task3_on': $r('app.media.task3_on'),
  'task4_off': $r('app.media.task4_off'),
  'task4_on': $r('app.media.task4_on'),
  'task5_off': $r('app.media.task5_off'),
  'task5_on': $r('app.media.task5_on'),
  'task6_off': $r('app.media.task6_off'),
  'task6_on': $r('app.media.task6_on'),
  'run1_off': $r('app.media.run1_off'),
  'run1_on': $r('app.media.run1_on'),
  'run3_off': $r('app.media.run3_off'),
  'run3_on': $r('app.media.run3_on'),
  'run5_off': $r('app.media.run5_off'),
  'run5_on': $r('app.media.run5_on')
}

//最后再换图片
export const AchievementMap_single = {
  '100_off': $r('app.media.ic_badge_30_off'),
  '100_on': $r('app.media.ic_badge_30_on'),
  '200_off': $r('app.media.ic_badge_50_off'),
  '200_on': $r('app.media.ic_badge_50_on'),
  '300_off': $r('app.media.ic_badge_99_off'),
  '300_on': $r('app.media.ic_badge_99_on')
}


export const TaskMapById: TaskInitListType = {
  1: {
    taskID: 1,
    taskName: $r('app.string.task_morning'),
    icon: $r("app.media.ic_task_morning"),
    dialogBg: $r('app.media.ic_dialog_getup'),
    targetValue: '08: 00',
    isOpen: false,
    unit: '',
    step: 0,
    isInit: true,
    isAlarm: false,
    startTime: '08: 00',
    endTime: '00: 00',
    frequency: '1, 2, 3, 4, 5, 6, 7',
    // 添加的新属性
    frequencyIds: [true, true, true, true, true, true, true]
  },
  2: {
    taskID: 2,
    taskName: $r('app.string.task_water'),
    icon: $r("app.media.ic_task_water"),
    dialogBg: $r('app.media.ic_dialog_drink'),
    targetValue: '0.25',
    isOpen: false,
    unit: 'L',
    step: 0.25,
    isInit: true,
    isAlarm: false,
    startTime: '08: 00',
    endTime: '00: 00',
    frequency: '1, 2, 3, 4, 5, 6, 7',
    // 添加的新属性
    frequencyIds: [true, true, true, true, true, true, true]
  },
  3: {
    taskID: 3,
    taskName: $r('app.string.task_apple'),
    icon: $r("app.media.ic_task_apple"),
    dialogBg: $r('app.media.ic_dialog_eat_apples'),
    targetValue: '1',
    isOpen: false,
    unit: '个',
    step: 1,
    isInit: true,
    isAlarm: false,
    startTime: '08: 00',
    endTime: '00: 00',
    frequency: '1, 2, 3, 4, 5, 6, 7',
    // 添加的新属性
    frequencyIds: [true, true, true, true, true, true, true]
  },
  4: {
    taskID: 4,
    taskName: $r('app.string.task_smile'),
    icon: $r("app.media.ic_task_smile"),
    dialogBg: $r('app.media.ic_dialog_smile'),
    targetValue: '1',
    isOpen: false,
    unit: '次',
    step: 1,
    isInit: true,
    isAlarm: false,
    startTime: '08: 00',
    endTime: '00: 00',
    frequency: '1, 2, 3, 4, 5, 6, 7',
    // 添加的新属性
    frequencyIds: [true, true, true, true, true, true, true]
  },
  5: {
    taskID: 5,
    taskName: $r('app.string.task_brush'),
    icon: $r("app.media.ic_task_brush"),
    dialogBg: $r('app.media.ic_dialog_brush_teeth'),
    targetValue: '1',
    isOpen: false,
    unit: '次',
    step: 1,
    isInit: true,
    isAlarm: false,
    startTime: '08: 00',
    endTime: '00: 00',
    frequency: '1, 2, 3, 4, 5, 6, 7',
    // 添加的新属性
    frequencyIds: [true, true, true, true, true, true, true]
  },
  6: {
    taskID: 6,
    taskName: $r('app.string.task_night'),
    icon: $r("app.media.ic_task_night"),
    dialogBg: $r('app.media.ic_dialog_sleep'),
    targetValue: '20: 00',
    isOpen: false,
    unit: '',
    step: 0,
    isInit: true,
    isAlarm: false,
    startTime: '08: 00',
    endTime: '00: 00',
    frequency: '1, 2, 3, 4, 5, 6, 7',
    // 添加的新属性
    frequencyIds: [true, true, true, true, true, true, true]
  },
  7: {
    taskID: 7,
    taskName: $r('app.string.task_runonemile'),
    icon: $r("app.media.ic_task_run"),
    dialogBg: $r('app.media.ic_dialog_run_one_mile'),
    targetValue: '1',
    isOpen: false,
    unit: '次',
    step: 1,
    isInit: true,
    isAlarm: false,
    startTime: '08: 00',
    endTime: '00: 00',
    frequency: '1, 2, 3, 4, 5, 6, 7',
    // 添加的新属性
    frequencyIds: [true, true, true, true, true, true, true]
  }
}

export const TaskItem: TaskInfo = {
  id: 1,
  taskID: 0,
  isOpen: false,
  date: '',
  targetValue: '7:00',
  isAlarm: true,
  startTime: 'string',
  endTime: 'string;',
  frequency: '',
  isDone: true,
  finValue: '6:58'
};

export const RemindContentMap = {
  1: {
    title: GET_UP_TASK_NAME,
    content: GET_UP_CONTENT
  },
  2: {
    title: DRINK_TASK_NAME,
    content: DRINK_CONTENT
  },
  3: {
    title: EAT_APPLE_TASK_NAME,
    content: EAT_APPLE_CONTENT
  },
  4: {
    title: SMILE_TASK_NAME,
    content: SMILE_CONTENT
  },
  5: {
    title: BRUSH_TEETH_TASK_NAME,
    content: BRUSH_TEETH_CONTENT
  },
  6: {
    title: SLEEP_TASK_NAME,
    content: SLEEP_CONTENT
  },
  7: {
    title: RUN_TASK_NAME,
    content: RUN_CONTENT
  },
};

export const ACHIEVEMENT_LEVEL_LIST = [3, 7, 30, 50, 73, 99];

//增加当日单项成就,吃苹果
export const ACHIEVEMENT_LEVEL_LIST_SINGLE = [100 ,200, 300];

// 新添加的任务名称列表
export const TASKS_NAME = ['早起', '喝水', '吃苹果', '微笑', '刷牙', '睡觉', '跑步']

// 新添加的成就等级
export const ACHIEVEMENT_RUN = [1, 3, 5];
export const ACHIEVEMENT_APPLE = [1, 3, 5];