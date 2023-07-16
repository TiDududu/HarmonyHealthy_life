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

import { BadgeCard , BadgeCard_single } from './BadgeCardComponent'
import { getAchievementLevel , getAchievementLevel_single } from '../model/AchieveModel'
import { getBadgeCardItems ,getBadgeCardItems_single } from '../viewmodel/AchievementViewModel'
import Logger from '../common/utils/Logger'
import { ACHIEVEMENT_LEVEL_KEY ,ACHIEVEMENT_LEVEL_KEY_SINGLE } from '../model/AchieveModel'
import * as commonConst from '../common/constants/CommonConstants';

@Component
export struct BadgePanel {
  @StorageProp(ACHIEVEMENT_LEVEL_KEY) successiveDays: number = 0;

  aboutToAppear() {
    Logger.debug('BadgePanel','aboutToAppear')
    getAchievementLevel()
  }

  build() {
    Flex({ direction: FlexDirection.Row, wrap: FlexWrap.Wrap }) {
      ForEach(getBadgeCardItems(this.successiveDays), (item) => {
        BadgeCard({ content: item[0], imgSrc: item[1]})
      })
    }
    .width(commonConst.FULL_WIDTH)
  }
}

//新增单项成就
@Component
export struct BadgePanel_single {
  @StorageProp(ACHIEVEMENT_LEVEL_KEY_SINGLE) successiveTimes: number = 0;

  aboutToAppear() {
    Logger.debug('BadgePanel_single','aboutToAppear')
    getAchievementLevel_single()
  }

  build() {
    Flex({ direction: FlexDirection.Row, wrap: FlexWrap.Wrap }) {
      ForEach(getBadgeCardItems_single(this.successiveTimes), (item) => {
        BadgeCard_single({ content: item[0], imgSrc: item[1]})
      })
    }
    .width(commonConst.FULL_WIDTH)
  }
}