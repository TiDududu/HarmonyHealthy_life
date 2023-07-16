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

import * as commonConst from '../common/constants/CommonConstants';
import { BadgePanel, BadgePanel_single } from './BadgePanelComponent';
import { TitleBar, TitleBar_single } from './TitleBarComponent';
import { BadgeRunPanel} from './runTaskPanelComponent'
import Logger from '../common/utils/Logger';

@Component
export struct AchievementIndex {
  // @Link BadgeCardItems_single: [string, Resource][];
  scroller: Scroller = new Scroller()
  private arr: number[] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
  aboutToAppear(){
    Logger.debug('AchievementIndex', 'aboutToAppear')
  }

  onPageShow () {
    Logger.debug('AchievementIndex', 'onPageShow')
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {

      Scroll(this.scroller) {
        Column({ space: commonConst.DEFAULT_20 }) {
          TitleBar()
          BadgePanel()

          //新增一个title
          TitleBar_single()
          BadgePanel_single()

          // 跑步历史累计
          BadgeRunPanel()
        }
        .padding(commonConst.DEFAULT_10)
        // .height(commonConst.FULL_HEIGHT)
        .width(commonConst.FULL_WIDTH)
        .backgroundColor($r('app.color.black'))
      }
      .scrollable(ScrollDirection.Vertical) // 滚动方向纵向
      .scrollBar(BarState.On) // 滚动条常驻显示
      .scrollBarColor(Color.Gray) // 滚动条颜色
      .scrollBarWidth(10) // 滚动条宽度
      .edgeEffect(EdgeEffect.None)
      .onScroll((xOffset: number, yOffset: number) => {
        console.info(xOffset + ' ' + yOffset)
      })
      .onScrollEdge((side: Edge) => {
        console.info('To the edge')
      })
      .onScrollEnd(() => {
        console.info('Scroll Stop')
      })
    }
  }
}
