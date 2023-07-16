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

export const ACHIEVEMENT_LEVEL_KEY = 'AchievementLevelKey';
export const ACHIEVEMENT_TASK_KEY = 'AchievementTaskKey';
export const ACHIEVEMENT_HISTORY_7 = 'AchievementTaskHistory_7';
// export const ACHIEVEMENT_TASK_ = 'AchievementTaskKey';

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

export function getHistoryTaskLevel(taskID: number) {
  TaskInfoApi.queryHistorySum(taskID, (res) => {

    AppStorage.SetOrCreate<Number>(ACHIEVEMENT_HISTORY_7, res);
  })
}

export function getAchievementTask(date: string) {

  TaskInfoApi.queryDone(date, (res) => {
    let ans = '';

    for ( let i = 0; i < res.length; i++){
      let taskInfo: TaskInfo = res[i];
      ans += String(taskInfo.taskID);
    }
    AppStorage.SetOrCreate<String>(ACHIEVEMENT_TASK_KEY, ans);
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
  TaskInfoApi.query(GLOBAL_KEY, true, (res) => {
    let taskInfo: TaskInfo = res;

      AppStorage.Set<Number>(ACHIEVEMENT_LEVEL_KEY_SINGLE, Number(taskInfo.finValue) / Number(taskInfo.targetValue));

  })
}

export function isReachNewAchievement_single(globalInfo: GlobalInfo): boolean {
  let achievementStr_single = globalInfo.achievements_single??'';
  let achievements_single = achievementStr_single.split(',');
  let finish_time: number = 200;  //try

  TaskInfoApi.query(GLOBAL_KEY, true, (res) => {
    let taskInfo: TaskInfo = res;

   // finish_time = Number(taskInfo.finValue) / Number(taskInfo.targetValue) ;

  });

  if (ACHIEVEMENT_LEVEL_LIST_SINGLE.indexOf(finish_time) >= 0 && achievements_single.indexOf(String(finish_time)) < 0) {
    return true;
  }
  return false;
}