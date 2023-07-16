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

import { BadgeCardTask } from './BadgeCardTaskComponent'
import { getAchievementTask} from '../model/AchieveModel'
import { getBadgeTaskCardItems } from '../viewmodel/AchievementViewModel'
import Logger from '../common/utils/Logger'
import { ACHIEVEMENT_TASK_KEY } from '../model/AchieveModel'
import * as commonConst from '../common/constants/CommonConstants';

@Component
export struct BadgeTaskPanel {
  @StorageProp(ACHIEVEMENT_TASK_KEY) taskAchieve: string='';

  aboutToAppear() {
    Logger.debug('BadgeTaskPanel','aboutToAppear')
    getAchievementTask(new Date().toDateString())
  }

  build() {
    Flex({ direction: FlexDirection.Row, wrap: FlexWrap.Wrap }) {
      ForEach(getBadgeTaskCardItems(this.taskAchieve), (item) => {
        BadgeCardTask({ content: item[0], imgSrc: item[1]})
      })
    }
    .width(commonConst.FULL_WIDTH)
  }
}
