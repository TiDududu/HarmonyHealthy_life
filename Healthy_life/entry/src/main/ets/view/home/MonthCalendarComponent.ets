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

import display from '@ohos.display';
import WeekCalendarMethods from '../../viewmodel/CalendarViewModel';
import MonthCalendarMethods from '../../viewmodel/MonthCalendarViewModel';
import { HomeStore } from '../../viewmodel/HomeViewModel';
import HealthText from '../../view/HealthTextComponent';
import { WeekDateModel } from '../../model/WeekCalendarModel';
import { sameDate } from '../../common/utils/Utils';
import * as commonConst from '../../common/constants/CommonConstants';
import Logger from '../../common/utils/Logger';

export const WEEK_DAY_WIDTH: number = 100 / commonConst.WEEK_DAY_NUM;
export const WEEK_DAY_HEIGHT: number = 38;
const DEFAULT_SCROLL_WIDTH = 336; // default calendar width
const DEFAULT_SCROLL_PERCENT = 0.934; // default calendar width percent
//const DEFAULT_LINE_NUMBER = 5; //默认日历行数

@Component
export struct MonthCalendar {
  @Link homeStore: HomeStore;
  currentPage: number = 1;
  private scroller: Scroller = new Scroller();
  scrollWidth: number = DEFAULT_SCROLL_WIDTH;

  aboutToAppear() {
    // get width
    try {
      let displayClass = display.getDefaultDisplaySync();
      this.scrollWidth = displayClass.width / displayClass.densityPixels * DEFAULT_SCROLL_PERCENT;
      Logger.info('HomeIndex', 'get the window scrollWidth: ' + this.scrollWidth);
    } catch (err) {
      Logger.error('HomeIndex->onScrollEnd', JSON.stringify(err));
    }
    this.homeStore.setSelectedShowDate(new Date().getTime()); //传入当前时间的时间戳，使得homeStore内的日期字符串与 得到更新
  }

  getProgressImg(item: WeekDateModel): Resource {
    if(item.date.getMonth()==this.homeStore.month) {
      let finNum = item.dayInfo?.finTaskNum || 0;
      if (finNum === 0) {
        return $r('app.media.ic_home_undone');
      }
      if (finNum === (item.dayInfo?.targetTaskNum || 0)) {
        return $r('app.media.ic_home_all_done');
      }
      return $r('app.media.ic_home_half_done');
    } else {
      return $r("app.media.ic_cross");
    }
  }

  @Builder ArrowIcon(isRight: boolean) {
    Row() {
      Image($r('app.media.ic_right_grey'))
        .width($r('app.float.default_6'))
        .height($r('app.float.default_12'))
    }
    .width($r('app.float.default_20'))
    .height($r('app.float.default_12'))
    .rotate({ z: 1, angle: isRight ? 0 : commonConst.DEFAULT_180 })
    .justifyContent(FlexAlign.Center)
    .onClick(() => isRight ? MonthCalendarMethods.goToNextMonth.call(this) : MonthCalendarMethods.gotoPreviousMonth.call(this))
  }

  build() {
    Row() {
      Column() {
        //月标题
        Row() {
          this.ArrowIcon(false)
          HealthText({ title: this.homeStore.monthTitle, fontSize: $r('app.float.default_14') })
            .margin($r('app.float.default_6'))
          this.ArrowIcon(true)
        }
        .justifyContent(FlexAlign.Center)

        //月日历，横向滚动
        Column({space:"8vp"}) {
          Row() {
            ForEach(this.homeStore.dateArr, (item: WeekDateModel, index: number) => {
              Column() {
                Text(item.weekTitle)
                  .fontSize($r('app.float.default_12'))
                  .fontWeight(commonConst.FONT_WEIGHT_500)
                  .fontColor(item.date.getDay()===(new Date(this.homeStore.showDate)).getDay() ? $r('app.color.blueColor') : $r('app.color.titleColor'))
                  .fontFamily($r('app.string.HarmonyHeiTi_Medium'))
                  .opacity(commonConst.OPACITY_6)
              }
              .width(`${WEEK_DAY_WIDTH}%`)
              .justifyContent(FlexAlign.SpaceBetween)
            })
          }

          ForEach(this.homeStore.weekArr, (item0: Array<WeekDateModel>, index0: number) => {
            Row() {
              ForEach(item0, (item1: WeekDateModel, index1: number) => {
                if(item1.date.getMonth()==this.homeStore.month) {
                  Column() {
                    //Image( (item1.date.getMonth()==this.homeStore.month)?this.getProgressImg(item1):$r("app.media.ic_cross"))
                    Image(this.getProgressImg(item1))
                      .height($r('app.float.default_28'))
                      .objectFit(ImageFit.Contain)
                      .margin({ top: commonConst.THOUSANDTH_80 })
                    Text(`${item1.date.getDate()}`)
                      .fontSize($r('app.float.default_12'))
                      .fontWeight(commonConst.FONT_WEIGHT_400)
                      .fontColor(item1.date.getTime() === (new Date(this.homeStore.showDate)).getTime() ? $r('app.color.blueColor') : $r('app.color.titleColor'))
                      .fontFamily($r('app.string.HarmonyHeiTi_Medium'))
                      .opacity(commonConst.OPACITY_6)
                  }
                  .height("38vp")
                  .width(`${WEEK_DAY_WIDTH}%`)
                  .justifyContent(FlexAlign.SpaceBetween)
                  .onClick(() => MonthCalendarMethods.calenderItemClickAction.call(this, item1, index1))
                } else {
                  Column() {
                    //Image( (item1.date.getMonth()==this.homeStore.month)?this.getProgressImg(item1):$r("app.media.ic_cross"))
                    // Image(this.getProgressImg(item1))
                    //   .height($r('app.float.default_28'))
                    //   .objectFit(ImageFit.Contain)
                    //   .margin({ top: commonConst.THOUSANDTH_80 })
                    //   .opacity(0.25)
                    // Text(`${item1.date.getDate()}`)
                    //   .fontSize($r('app.float.default_12'))
                    //   .fontWeight(commonConst.FONT_WEIGHT_400)
                    //   .fontColor(item1.date.getTime() === (new Date(this.homeStore.showDate)).getTime() ? $r('app.color.blueColor') : $r('app.color.titleColor'))
                    //   .fontFamily($r('app.string.HarmonyHeiTi_Medium'))
                    //   .opacity(commonConst.OPACITY_6)
                  }
                  .height("38vp")
                  .width(`${WEEK_DAY_WIDTH}%`)
                  .justifyContent(FlexAlign.SpaceBetween)
                }
              })
            }
          })
        }
      }
      .borderRadius($r('app.float.default_24'))
      .backgroundColor('rgba(255,255,255,0.75)')
      .width(commonConst.THOUSANDTH_1000)
      .height(commonConst.THOUSANDTH_1000)
      .padding({ top: commonConst.THOUSANDTH_50, bottom: commonConst.THOUSANDTH_50 })
    }
    .width(commonConst.THOUSANDTH_1000)
    .height('76%')
    .padding(commonConst.THOUSANDTH_33)
  }
}