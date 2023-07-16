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

import { BadgeCardRun } from './runTaskCardComponent'
import { getHistoryTaskLevel} from '../model/AchieveModel'
import { getHistoryCardItems } from '../viewmodel/AchievementViewModel'
import Logger from '../common/utils/Logger'
import { ACHIEVEMENT_HISTORY_7 } from '../model/AchieveModel'
import * as commonConst from '../common/constants/CommonConstants';

@Component
export struct BadgeRunPanel {
  @StorageProp(ACHIEVEMENT_HISTORY_7) runLevel: number=0;

  aboutToAppear() {
    Logger.debug('BadgeTaskPanel','aboutToAppear')
    getHistoryTaskLevel(7)  // 跑步的任务id是7
  }

  build() {
    Column({space: commonConst.DEFAULT_18}) {
      Text('我的跑步里程')  // 跑步累计已达%d公里
        .lineHeight($r('app.float.default_20'))
        .fontSize($r('app.float.default_18'))
        .fontColor($r('app.color.white'))
        .width('100%')
        .textAlign(TextAlign.Start)
        .padding({left: commonConst.ACHIEVE_TITLE_BAR_LEFT,top: commonConst.ACHIEVE_TITLE_BAR_TOP})
      Flex({ direction: FlexDirection.Row, wrap: FlexWrap.Wrap }) {
        ForEach(getHistoryCardItems(this.runLevel), (item) => {
          BadgeCardRun({ content: item[0], imgSrc: item[1]})
        })
      }
      .width(commonConst.FULL_WIDTH)
    }
    .padding({top: commonConst.ACHIEVE_CARD_TOP, bottom: commonConst.ACHIEVE_CARD_BOTTOM})
  }
}
