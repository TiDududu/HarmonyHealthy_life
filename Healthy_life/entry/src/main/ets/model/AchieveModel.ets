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

import { ACHIEVEMENT_LEVEL_LIST ,ACHIEVEMENT_LEVEL_LIST_SINGLE } from './TaskInitList';
import GlobalInfo from '../common/bean/GlobalInfo';
import GlobalInfoApi from '../common/database/tables/GlobalInfoApi';
import TaskInfo from '../common/bean/TaskInfo';
import TaskInfoApi from '../common/database/tables/TaskInfoApi';
import {GLOBAL_KEY} from '../common/constants/CommonConstants';

import { dateToStr, monthFormat, weekDateFormat } from '../common/utils/Utils';

export const ACHIEVEMENT_LEVEL_KEY = 'AchievementLevelKey';

//新增单项成就等级
export const ACHIEVEMENT_LEVEL_KEY_SINGLE = 'AchievementLevelKeySingle';

export function getAchievementLevel() {
  GlobalInfoApi.query((res) => {
    let globalInfo: GlobalInfo = res;

    let achievementStr = globalInfo.achievements??'';
    let achievements = achievementStr.split(',');
    if (achievements.length > 0) {
      AppStorage.Set<Number>(ACHIEVEMENT_LEVEL_KEY, Number(achievements[achievements.length - 1]));
    }
  })

}

export function isReachNewAchievement(globalInfo: GlobalInfo): boolean {
  let achievementStr = globalInfo.achievements??'';
  let achievements = achievementStr.split(',');

  if (ACHIEVEMENT_LEVEL_LIST.indexOf(globalInfo.checkInDays) >= 0 && achievements.indexOf(String(globalInfo.checkInDays)) < 0) {
    return true;
  }
  return false;
}

//新增单项成就
export function getAchievementLevel_single() {

  let Day = new Date();
  Day.setDate(Day.getDate());
  Day = new Date(Day);
  let DayStr = dateToStr(Day);

  TaskInfoApi.query(DayStr, true, (res) => {
    let taskInfo: TaskInfo = res[0];
    AppStorage.Set<string>(ACHIEVEMENT_LEVEL_KEY_SINGLE, String(Math.ceil(Number(taskInfo.finValue) / Number(taskInfo.targetValue))*100));
  })
  // GlobalInfoApi.query((res) => {
  //   let globalInfo: GlobalInfo = res;
  //
  //   let achievementStr = globalInfo.achievements_single??'';
  //   let achievements = achievementStr.split(',');
  //   if (achievements.length > 0) {
  //     AppStorage.Set<Number>(ACHIEVEMENT_LEVEL_KEY_SINGLE, Number(achievements[achievements.length - 1]));
  //   }
  // })

}

export function isReachNewAchievement_single(globalInfo: GlobalInfo): boolean {
  let achievementStr_single = globalInfo.achievements_single??'';
  let achievements_single = achievementStr_single.split(',');

  let Day = new Date();
  Day.setDate(Day.getDate());
  Day = new Date(Day);
  let DayStr = dateToStr(Day);


  TaskInfoApi.query_apple(DayStr, true, (res) => {
    let taskInfo: TaskInfo = res[0];

    globalInfo.finish_time = Math.ceil(Number(taskInfo.finValue) / Number(taskInfo.targetValue) * 100) ;

  });

  if (ACHIEVEMENT_LEVEL_LIST_SINGLE.indexOf(globalInfo.finish_time) >= 0) {
    return true;
  }
  return false;
}