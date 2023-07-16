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

import { HomeStore } from '../../viewmodel/HomeViewModel';
import { WeekCalendar } from './WeekCalendarComponent';
import { MonthCalendar } from './MonthCalendarComponent';
import * as commonConst from '../../common/constants/CommonConstants';
import HealthText from '../../view/HealthTextComponent';
import { ACHIEVE_CARD_TOP } from '../../common/constants/CommonConstants';


@Extend(Text) function titleTextStyle () {
  .fontSize($r('app.float.default_16'))
  .fontWeight(commonConst.FONT_WEIGHT_500)
  .width(commonConst.THOUSANDTH_1000)
  .fontFamily($r('app.string.HarmonyHeiTi_Medium'))
  .fontColor($r(`app.element.color.titleColor`))
}

@Component
export default struct HomeTopView {
  @Link homeStore: HomeStore;
  @Link is_month: boolean ;
  @Link selectedOptionIndex: number ;

  build() {
    Stack({alignContent:Alignment.TopEnd}){
      //背景选择
      Column() {
        Select([{value:'默认',icon: $r('app.media.blue')},
          {value:'粉色',icon: $r('app.media.colorpink')},
          {value:'黄色',icon: $r('app.media.coloryellow')},
          {value:'灰色',icon: $r('app.media.grey')}])
          .height(20)
          .opacity(0.3)
          .margin({top:5})
          .selected(0)
          .value('更换主题')
          .font({size: 15, weight:200, family: 'serif', style: FontStyle.Normal })
          .fontColor('#ff626262')
          .selectedOptionFont({size: 15, weight: 200, family: 'serif', style: FontStyle.Normal })
          .optionFont({size: 10, weight: 100, family: 'serif', style: FontStyle.Normal })
          .onSelect((index:number)=>{
            this.selectedOptionIndex = index;
          })
      }.zIndex(2)
      //其他上层页面
      Stack({ alignContent: Alignment.Top }) {
        if(this.selectedOptionIndex == 0){
          Column() {
            Text($r('app.string.target_progress'))
              .titleTextStyle()
              .opacity(commonConst.OPACITY_6)
              .padding({ left: $r('app.float.default_24') })
            Row() {
              HealthText({
                title: this.homeStore.getDonePercent(),
                fontSize: $r('app.float.default_72'),
                fontFamily: $r('app.string.HarmonyHeiTi_Bold'),
                fontWeight: commonConst.FONT_WEIGHT_700
              })
              Text('%')
                .titleTextStyle()
                .fontSize($r('app.float.default_40'))
                .margin({ top: $r('app.float.default_12'), left: $r('app.float.default_8') })
            }
            .width(commonConst.THOUSANDTH_1000)
            .padding({ left: $r('app.float.default_24') })

            Column(){
              Stack({ alignContent: Alignment.TopEnd }) {
                if (this.is_month) {
                  MonthCalendar({ homeStore: $homeStore })
                } else {
                  WeekCalendar({ homeStore: $homeStore })
                }

                Text(this.is_month ? "M" : "W") //Note:注意这个格式化用法
                  .fontSize("15vp")
                  .fontWeight(commonConst.FONT_WEIGHT_500)
                  .fontColor($r('app.color.blueColor'))
                  .borderRadius($r('app.float.default_6'))
                  .height(28)
                  .width(28)
                  .border({ color: $r('app.color.blueColor'), width: $r('app.float.default_1') })
                  .margin({ top: 25, right: 25 })
                  .textAlign(TextAlign.Center)
                  .onClick(() => {
                    let showDate=new Date(this.homeStore.showDate);
                    this.is_month = !this.is_month;
                    this.homeStore.setSelectedShowDate(this.homeStore.showDate);
                    this.homeStore.getThisMonthData(showDate,()=>{});
                  })

              }
              Text($r('app.string.task_list'))
                .fontSize($r('app.float.default_18'))
                .titleTextStyle()
                .backgroundColor($r('app.color.primaryBgColor'))
                .borderWidth({ left:5 ,bottom: 3 })
                .borderRadius({ bottomLeft: 5, bottomRight: 5 })
                .borderColor($r('app.color.primaryBgColor'))
            }

          }
          .height(this.is_month ? commonConst.THOUSANDTH_650 : commonConst.THOUSANDTH_500)
          .backgroundImagePosition({ x: 0, y: 0 })
          .backgroundImage($r('app.media.ic_home_bg'))
          .backgroundImageSize(this.is_month ? { width: commonConst.THOUSANDTH_1000, height: commonConst.THOUSANDTH_650 } :
            { width: commonConst.THOUSANDTH_1000, height: commonConst.THOUSANDTH_900 })
          .justifyContent(FlexAlign.End)
        }
        //如果选择紫色主题
        if(this.selectedOptionIndex == 1){
          Column() {
            Text($r('app.string.target_progress'))
              .titleTextStyle()
              .opacity(commonConst.OPACITY_6)
              .padding({ left: $r('app.float.default_24') })
            Row() {
              HealthText({
                title: this.homeStore.getDonePercent(),
                fontSize: $r('app.float.default_72'),
                fontFamily: $r('app.string.HarmonyHeiTi_Bold'),
                fontWeight: commonConst.FONT_WEIGHT_700
              })
              Text('%')
                .titleTextStyle()
                .fontSize($r('app.float.default_40'))
                .margin({ top: $r('app.float.default_12'), left: $r('app.float.default_8') })
            }
            .width(commonConst.THOUSANDTH_1000)
            .padding({ left: $r('app.float.default_24') })

            Column(){
              Stack({ alignContent: Alignment.TopEnd }) {
                if (this.is_month) {
                  MonthCalendar({ homeStore: $homeStore })
                } else {
                  WeekCalendar({ homeStore: $homeStore })
                }

                Text(this.is_month ? "M" : "W") //Note:注意这个格式化用法
                  .fontSize("15vp")
                  .fontWeight(commonConst.FONT_WEIGHT_500)
                  .fontColor($r('app.color.blueColor'))
                  .borderRadius($r('app.float.default_6'))
                  .height(28)
                  .width(28)
                  .border({ color: $r('app.color.blueColor'), width: $r('app.float.default_1') })
                  .margin({ top: 25, right: 25 })
                  .textAlign(TextAlign.Center)
                  .onClick(() => {
                    this.is_month = !this.is_month
                  })

              }
              Text($r('app.string.task_list'))
                .fontSize($r('app.float.default_18'))
                .titleTextStyle()
                .backgroundColor($r('app.color.primaryBgColor'))
                .borderWidth({ bottom: 3 })
                .borderRadius({ bottomLeft: 5, bottomRight: 5 })
                .borderColor($r('app.color.primaryBgColor'))
            }

          }
          .height(this.is_month ? commonConst.THOUSANDTH_650 : commonConst.THOUSANDTH_500)
          .backgroundImagePosition({ x: 0, y: 0 })
          .backgroundImage($r('app.media.pink'))
          .backgroundImageSize(this.is_month ? { width: commonConst.THOUSANDTH_1000, height: commonConst.THOUSANDTH_650 } :
            { width: commonConst.THOUSANDTH_1000, height: commonConst.THOUSANDTH_900 })
          .justifyContent(FlexAlign.End)
        }
        //选择黄色主题
        if(this.selectedOptionIndex == 2){
          Column() {
            Text($r('app.string.target_progress'))
              .titleTextStyle()
              .opacity(commonConst.OPACITY_6)
              .padding({ left: $r('app.float.default_24') })
            Row() {
              HealthText({
                title: this.homeStore.getDonePercent(),
                fontSize: $r('app.float.default_72'),
                fontFamily: $r('app.string.HarmonyHeiTi_Bold'),
                fontWeight: commonConst.FONT_WEIGHT_700
              })
              Text('%')
                .titleTextStyle()
                .fontSize($r('app.float.default_40'))
                .margin({ top: $r('app.float.default_12'), left: $r('app.float.default_8') })
            }
            .width(commonConst.THOUSANDTH_1000)
            .padding({ left: $r('app.float.default_24') })

            Column(){
              Stack({ alignContent: Alignment.TopEnd }) {
                if (this.is_month) {
                  MonthCalendar({ homeStore: $homeStore })
                } else {
                  WeekCalendar({ homeStore: $homeStore })
                }

                Text(this.is_month ? "M" : "W") //Note:注意这个格式化用法
                  .fontSize("15vp")
                  .fontWeight(commonConst.FONT_WEIGHT_500)
                  .fontColor($r('app.color.blueColor'))
                  .borderRadius($r('app.float.default_6'))
                  .height(28)
                  .width(28)
                  .border({ color: $r('app.color.blueColor'), width: $r('app.float.default_1') })
                  .margin({ top: 25, right: 25 })
                  .textAlign(TextAlign.Center)
                  .onClick(() => {
                    let showDate=new Date(this.homeStore.showDate);
                    this.is_month = !this.is_month;
                    this.homeStore.setSelectedShowDate(this.homeStore.showDate);
                    this.homeStore.getThisMonthData(showDate,()=>{});
                  })

              }
              Text($r('app.string.task_list'))
                .fontSize($r('app.float.default_18'))
                .titleTextStyle()
                .backgroundColor($r('app.color.primaryBgColor'))
                .borderWidth({ left:5 ,bottom: 3 })
                .borderRadius({ bottomLeft: 5, bottomRight: 5 })
                .borderColor($r('app.color.primaryBgColor'))
            }

          }
          .height(this.is_month ? commonConst.THOUSANDTH_650 : commonConst.THOUSANDTH_500)
          .backgroundImagePosition({ x: 0, y: 0 })
          .backgroundImage($r('app.media.yellow'))
          .backgroundImageSize(this.is_month ? { width: commonConst.THOUSANDTH_1000, height: commonConst.THOUSANDTH_650 } :
            { width: commonConst.THOUSANDTH_1000, height: commonConst.THOUSANDTH_900 })
          .justifyContent(FlexAlign.End)
        }
        //选择灰色主题
        if(this.selectedOptionIndex == 3){
          Column() {
            Text($r('app.string.target_progress'))
              .titleTextStyle()
              .opacity(commonConst.OPACITY_6)
              .padding({ left: $r('app.float.default_24') })
            Row() {
              HealthText({
                title: this.homeStore.getDonePercent(),
                fontSize: $r('app.float.default_72'),
                fontFamily: $r('app.string.HarmonyHeiTi_Bold'),
                fontWeight: commonConst.FONT_WEIGHT_700
              })
              Text('%')
                .titleTextStyle()
                .fontSize($r('app.float.default_40'))
                .margin({ top: $r('app.float.default_12'), left: $r('app.float.default_8') })
            }
            .width(commonConst.THOUSANDTH_1000)
            .padding({ left: $r('app.float.default_24') })

            Column(){
              Stack({ alignContent: Alignment.TopEnd }) {
                if (this.is_month) {
                  MonthCalendar({ homeStore: $homeStore })
                } else {
                  WeekCalendar({ homeStore: $homeStore })
                }

                Text(this.is_month ? "M" : "W") //Note:注意这个格式化用法
                  .fontSize("15vp")
                  .fontWeight(commonConst.FONT_WEIGHT_500)
                  .fontColor($r('app.color.blueColor'))
                  .borderRadius($r('app.float.default_6'))
                  .height(28)
                  .width(28)
                  .border({ color: $r('app.color.blueColor'), width: $r('app.float.default_1') })
                  .margin({ top: 25, right: 25 })
                  .textAlign(TextAlign.Center)
                  .onClick(() => {
                    let showDate=new Date(this.homeStore.showDate);
                    this.is_month = !this.is_month;
                    this.homeStore.setSelectedShowDate(this.homeStore.showDate);
                    this.homeStore.getThisMonthData(showDate,()=>{});
                  })

              }
              Text($r('app.string.task_list'))
                .fontSize($r('app.float.default_18'))
                .titleTextStyle()
                .backgroundColor($r('app.color.primaryBgColor'))
                .borderWidth({ left:5 ,bottom: 3 })
                .borderRadius({ bottomLeft: 5, bottomRight: 5 })
                .borderColor($r('app.color.primaryBgColor'))
            }

          }
          .height(this.is_month ? commonConst.THOUSANDTH_650 : commonConst.THOUSANDTH_500)
          .backgroundImagePosition({ x: 0, y: 0 })
          .backgroundImage($r('app.media.darkground'))
          .backgroundImageSize(this.is_month ? { width: commonConst.THOUSANDTH_1000, height: commonConst.THOUSANDTH_650 } :
            { width: commonConst.THOUSANDTH_1000, height: commonConst.THOUSANDTH_900 })
          .justifyContent(FlexAlign.End)
        }
      }.backgroundColor($r('app.color.primaryBgColor'))
      .zIndex(1)    }
  }
}

