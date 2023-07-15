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
import DayInfo from '../common/bean/DayInfo';
import { WEEK_TITLES, dateToStr } from '../common/utils/Utils'
import Logger from '../common/utils/Logger'

// day number of on week
export const WEEK_DAY_NUM: number = 7;

export class WeekDateModel {
  weekTitle: string;
  dateStr: string;
  date: Date;
  dayInfo: DayInfo;
  taskList: TaskInfo[] = [];

  constructor(weekTitle: string, dateStr: string, date: Date) {
    this.weekTitle = weekTitle;
    this.dateStr = dateStr;
    this.date = date;
  }
}

/**
 * init calendar data
 *
 * @param date  today str
 */
export function initializeOnStartUp_Month(date: Date):[Array<Array<WeekDateModel>>, Array<Array<string>>]  {
  let arrMonth:Array<Array<string>>=[];
  let strArrMonth: Array<Array<WeekDateModel>>=[];

  let currentDate = new Date(date);
  const currentMonth = currentDate.getMonth();
  currentDate.setDate(1);

  while (currentDate.getMonth() === currentMonth) {
    let [arr, strArr] = [[], []];
    let currentDay = currentDate.getDay() - 1;
    if (currentDate.getDay() === 0) {
      currentDay = 6;
    }
    Logger.debug('WeekCalendarModel', currentDate.toISOString());
    // Monday is the first day of the week
    currentDate.setDate(currentDate.getDate() - currentDay);

    for (let index = 0; index < WEEK_DAY_NUM; index++) {
      let tempDate = new Date(currentDate);
      tempDate.setDate(currentDate.getDate() + index);
      let dateStr = dateToStr(tempDate);
      strArr.push(dateStr);
      arr.push(new WeekDateModel(WEEK_TITLES[tempDate.getDay()], dateStr, tempDate));
    }
    Logger.debug('WeekCalendarModel', 'initialWeekDate' + JSON.stringify(arr));
    arrMonth.push(strArr)
    strArrMonth.push(arr);
    currentDate.setDate(currentDate.getDate() + 7); // Move to the next week
  }

  return [strArrMonth,arrMonth];
}


/**
 * get previous week data
 *
 * @param showDate  base data
 */
export function getPreviousWeek(showDate: Date): [Array<WeekDateModel>, Array<string>] {
  Logger.debug('WeekCalendarModel', 'get week date by date: ' + showDate.toDateString())
  let arr: Array<WeekDateModel> = [];
  let strArr: Array<string> = [];
  let currentDay = showDate.getDay() - 1;
  // monday is first day of week
  showDate.setDate(showDate.getDate() - currentDay);
  for (let index = WEEK_DAY_NUM; index > 0; index--) {
    let tempDate = new Date(showDate);
    tempDate.setDate(showDate.getDate() - index);
    let dateStr = dateToStr(tempDate);
    strArr.push(dateStr);
    arr.push(new WeekDateModel(WEEK_TITLES[tempDate.getDay()], dateStr, tempDate))
  }
  Logger.debug('WeekCalendarModel', JSON.stringify(arr))
  return [arr, strArr];
}

