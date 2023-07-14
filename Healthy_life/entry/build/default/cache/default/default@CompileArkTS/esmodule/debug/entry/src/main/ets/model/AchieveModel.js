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
import { ACHIEVEMENT_LEVEL_LIST } from '@bundle:com.example.healthy_life/entry/ets/model/TaskInitList';
import GlobalInfoApi from '@bundle:com.example.healthy_life/entry/ets/common/database/tables/GlobalInfoApi';
export const ACHIEVEMENT_LEVEL_KEY = 'AchievementLevelKey';
export function getAchievementLevel() {
    GlobalInfoApi.query((res) => {
        var _a;
        let globalInfo = res;
        let achievementStr = (_a = globalInfo.achievements) !== null && _a !== void 0 ? _a : '';
        let achievements = achievementStr.split(',');
        if (achievements.length > 0) {
            AppStorage.Set(ACHIEVEMENT_LEVEL_KEY, Number(achievements[achievements.length - 1]));
        }
    });
}
export function isReachNewAchievement(globalInfo) {
    var _a;
    let achievementStr = (_a = globalInfo.achievements) !== null && _a !== void 0 ? _a : '';
    let achievements = achievementStr.split(',');
    if (ACHIEVEMENT_LEVEL_LIST.indexOf(globalInfo.checkInDays) >= 0 && achievements.indexOf(String(globalInfo.checkInDays)) < 0) {
        return true;
    }
    return false;
}
//# sourceMappingURL=AchieveModel.js.map