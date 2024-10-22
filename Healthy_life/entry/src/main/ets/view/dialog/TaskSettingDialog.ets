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

import prompt from '@system.prompt';
import { ITaskItem } from '../../model/TaskInitList';
import { frequencyRange } from '../../common/utils/Utils';
import { returnTimeStamp, createAppleRange, createDrinkRange, createSmileRange, createBrushteethRange, createRunRange, formatTime } from '../../viewmodel/TaskViewModel';
import { taskType } from '../../common/bean/TaskInfo';
import * as commonConst from '../..//common/constants/CommonConstants';
import { FrequencyContentType } from '../../model/TaskInitList';
import Logger from '../../common/utils/Logger';

@CustomDialog
export struct TargetSettingDialog {
  @Consume settingParams: ITaskItem;
  controller: CustomDialogController;
  drinkRange: string[] = createDrinkRange();
  appleRange: string[] = createAppleRange();

  //增加微笑和刷牙
  smileRange: string[] = createSmileRange();
  brushteethRange: string[] = createBrushteethRange();

  //增加跑步一公里
  runRange: string[] = createRunRange();

  currentValue: string = this.settingParams.targetValue;
  currentTime: string = commonConst.DEFAULT_TIME;

  compareTime(startTime: string, endTime: string) {
    if (returnTimeStamp(this.currentTime) < returnTimeStamp(startTime) ||
    returnTimeStamp(this.currentTime) > returnTimeStamp(endTime)) {
      prompt.showToast({
        message: commonConst.CHOOSE_TIME_OUT_RANGE
      })
      return false;
    }
    return true;
  }

  setTargetValue() {
    if (this.settingParams?.taskID === taskType.getup) {
      if (!this.compareTime(commonConst.GET_UP_EARLY_TIME, commonConst.GET_UP_LATE_TIME)) {
        return;
      }
      this.settingParams.targetValue = this.currentTime;
      return;
    }
    if (this.settingParams?.taskID === taskType.sleepEarly) {
      if (!this.compareTime(commonConst.SLEEP_EARLY_TIME, commonConst.SLEEP_LATE_TIME)) {
        return;
      }
      this.settingParams.targetValue = this.currentTime;
      return;
    }
    this.settingParams.targetValue = this.currentValue;
  }

  build() {
    Column() {
      Row() {
        Text($r('app.string.target_setting')).fontSize(commonConst.DEFAULT_20).margin({ right: commonConst.DEFAULT_12 })
        Text(this.settingParams?.taskID === taskType.getup ?
        commonConst.GET_UP_TIME_RANGE :
            this.settingParams?.taskID === taskType.sleepEarly ?
          commonConst.SLEEP_TIME_RANGE : '')
          .fontSize(commonConst.DEFAULT_16)
      }
      .width(commonConst.THOUSANDTH_1000)
      .justifyContent(FlexAlign.Start)

      if ([taskType.getup, taskType.sleepEarly].indexOf(this.settingParams?.taskID) > commonConst.HAS_NO_INDEX) {
        TimePicker({
          selected: new Date(`${new Date().toDateString()} 8:00:00`),
        })
          .height(commonConst.THOUSANDTH_800)
          .useMilitaryTime(true)
          .onChange((value: TimePickerResult) => {
            this.currentTime = formatTime(value);
          })
      }
      else {
        TextPicker({ range: this.settingParams?.taskID === taskType.drinkWater ? this.drinkRange :
          (this.settingParams?.taskID === taskType.eatApple ? this.appleRange:
            (this.settingParams?.taskID === taskType.smile ? this.smileRange :
              (this.settingParams?.taskID === taskType.brushTeeth ? this.brushteethRange : this.runRange)
            )
          )
        })
          .width(commonConst.THOUSANDTH_900,)
          .height(commonConst.THOUSANDTH_800,)
          .onChange((value) => {
            this.currentValue = value?.split(' ')[0];
          })
      }


      Row() {
        Text($r('app.string.cancel')).fontSize(commonConst.DEFAULT_20).fontColor($r('app.color.blueColor'))
          .onClick(() => {
            this.currentTime = commonConst.DEFAULT_TIME;
            this.currentValue = '';
            this.controller.close();
          })

        Text($r('app.string.confirm')).fontSize(commonConst.DEFAULT_20).fontColor($r('app.color.blueColor'))
          .onClick(() => {
            this.setTargetValue();
            this.controller.close();
          })
      }
      .justifyContent(FlexAlign.SpaceAround)
      .width(commonConst.THOUSANDTH_1000)
      .height(commonConst.DEFAULT_28)
      .margin({ bottom: commonConst.DEFAULT_20 })
    }
    .justifyContent(FlexAlign.Center)
    .height(commonConst.THOUSANDTH_560)
    .padding(commonConst.DEFAULT_12)
  }
}

@CustomDialog
export struct RemindTimeDialog {
  @Consume settingParams: ITaskItem;
  controller: CustomDialogController;
  currentTime: string = commonConst.DEFAULT_TIME;

  build() {
    Column() {
      Column() {
        Text($r('app.string.remind_time'))
          .fontSize(commonConst.DEFAULT_20)
          .margin({ top: commonConst.DEFAULT_10 })
          .width(commonConst.THOUSANDTH_1000)
          .textAlign(TextAlign.Start)
      }
      .width(commonConst.THOUSANDTH_900)

      TimePicker({
        selected: new Date(`${new Date().toDateString()} 8:00:00`),
      })
        .height(commonConst.THOUSANDTH_800)
        .useMilitaryTime(true)
        .onChange((value: TimePickerResult) => {
          this.currentTime = formatTime(value);
        })

      Row() {
        Text($r('app.string.cancel')).fontSize(commonConst.DEFAULT_20).fontColor($r('app.color.blueColor'))
          .onClick(() => {
            this.currentTime = commonConst.DEFAULT_TIME;
            this.controller.close();
          })

        Text($r('app.string.confirm')).fontSize(commonConst.DEFAULT_20).fontColor($r('app.color.blueColor'))
          .onClick(() => {
            this.settingParams.startTime = this.currentTime;
            this.controller.close();
          })
      }
      .justifyContent(FlexAlign.SpaceAround)
      .width(commonConst.THOUSANDTH_1000)
      .height(commonConst.DEFAULT_28)
      .margin({ bottom: commonConst.DEFAULT_20 })
    }
    .justifyContent(FlexAlign.Center)
    .height(commonConst.THOUSANDTH_560)
    .padding(commonConst.DEFAULT_12)
  }
}

@CustomDialog
export struct FrequencyDialog {
  @Consume settingParams: ITaskItem;
  @Consume frequency: string;
  @Consume frequencyIds: boolean[];
  private controller: CustomDialogController;
  private currentFrequency: string = commonConst.EVERYDAY;
  private frequencyChooseRange: FrequencyContentType[] = frequencyRange();
  // private frequencyIds: bool[] =

  setFrequency() {
    // const checkedArr = this.frequencyChooseRange.filter((item) => item?.isChecked)
    const checkedArr = this.frequencyChooseRange.filter((item) => this.frequencyIds[item?.id-1]);

    if (checkedArr.length === this.frequencyChooseRange.length || checkedArr.length === commonConst.NO_LENGTH) {
      this.currentFrequency = commonConst.EVERYDAY;
      this.settingParams.frequency = commonConst.INIT_WEEK_IDS;
      return;
    }
    this.currentFrequency = checkedArr.reduce((sum, current) => {
      return sum + ' ' + current?.label;
    }, '')
    this.settingParams.frequency = checkedArr.reduce((sum, current) => {
      return sum === '' ? sum + current?.id : sum + ',' + current?.id;
    }, '')
  }
  aboutToAppear(){
    Logger.info('datianli'+this.frequencyIds);
  }


  build() {
    Column() {
      Column() {
        Text($r('app.string.set_your_frequency'))
          .fontSize(commonConst.DEFAULT_20)
          .margin({ top: commonConst.DEFAULT_10 })
          .width(commonConst.THOUSANDTH_1000)
          .textAlign(TextAlign.Start)
      }
      .width(commonConst.THOUSANDTH_900)

      List() {
        ForEach(this.frequencyChooseRange, (item) => {
          ListItem() {
            Row() {
              Text(item?.label).fontSize(commonConst.DEFAULT_20)
              Toggle({ type: ToggleType.Checkbox, isOn: this.frequencyIds[item.id-1]})  // 使用新的属性
                .onChange((isOn) => {
                  item.isChecked = isOn;
                  Logger.info("picked fre"+isOn)
                  // 如果选中了复选框，则在数组中添加元素
                  // if (isOn) {
                  //   if (!this.settingParams.frequencyIds[item.id-1]) {
                  //
                  //     this.settingParams.frequencyIds[item.id-1] = true;
                  //   }
                  // }
                  // // 如果取消了复选框的选中，则从数组中删除元素
                  // else {
                  //
                  //   if (this.settingParams.frequencyIds[item.id-1]) {
                  //     this.settingParams.frequencyIds[item.id-1] = false;
                  //   }
                  // }
                  this.frequencyIds[item.id - 1] = isOn;
                  // this.frequencyIds = this.settingParams.frequencyIds
                })
            }
            .width(commonConst.THOUSANDTH_1000)
            .justifyContent(FlexAlign.SpaceBetween)
            .height(commonConst.DEFAULT_60)
          }
        })
      }
      .divider({
        strokeWidth: commonConst.DEFAULT_2,
        color: $r('app.color.btnBgColor')
      })
      .flexGrow(1)
      .padding(commonConst.DEFAULT_12)
      .width(commonConst.THOUSANDTH_1000)

      Row() {
        Text($r('app.string.cancel')).fontSize(commonConst.DEFAULT_20).fontColor($r('app.color.blueColor'))
          .onClick(() => {
            this.controller.close();
          })

        Text($r('app.string.confirm')).fontSize(commonConst.DEFAULT_20).fontColor($r('app.color.blueColor'))
          .onClick(() => {
            this.setFrequency();
            this.frequency = this.currentFrequency;
            // this.frequencyIds = this.settingParams.frequencyIds
            // this.settingParams.frequency = this.settingParams.frequencyIds.join(',');
            this.controller.close();
          })
      }
      .justifyContent(FlexAlign.SpaceAround)
      .width(commonConst.THOUSANDTH_900)
      .height(commonConst.DEFAULT_28)
      .margin({ bottom: commonConst.DEFAULT_16 })
    }
    .justifyContent(FlexAlign.Center)
    .height(commonConst.THOUSANDTH_900)
    .padding(commonConst.DEFAULT_12)
  }
}