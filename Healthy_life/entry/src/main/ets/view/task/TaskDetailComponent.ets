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


import router from '@ohos.router';
import prompt from '@system.prompt';
import common from '@ohos.app.ability.common';
import { ITaskItem } from '../../model/TaskInitList';
import Logger from '../../common/utils/Logger';
import * as commonConst from '../../common/constants/CommonConstants';
import { taskType } from '../../common/bean/TaskInfo';
import {
  TaskChooseItem,
  TargetSetItem,
  OpenRemindItem,
  RemindTimeItem,
  FrequencyItem
} from './TaskEditListItem';
import { BroadCast, BroadCastType } from '../../common/utils/BroadCast';
import { HealthDataSrcMgr } from '../../common/utils/HealthDataSrcMgr';
import { initFrequencyString, addTask, formatParams } from '../../viewmodel/TaskViewModel';
import { TaskDialogView } from '../dialog/TaskDialogView';
import { frequencyRange } from '../../common/utils/Utils';

@Styles function listItemStyle() {
  .backgroundColor($r('app.color.white'))
  .height(commonConst.DEFAULT_56)
  .borderRadius(commonConst.DEFAULT_10)
  .padding({ left: commonConst.DEFAULT_12, right: commonConst.DEFAULT_12 })
}

@Component
export default struct TaskDetail {
  @Provide broadCast: BroadCast = HealthDataSrcMgr.getInstance().getBroadCast();
  @Provide @Watch('onParamsChanged') settingParams: ITaskItem = this.parseRouterParams();
  @Provide frequency: string = initFrequencyString(this.settingParams?.frequency);
  @Provide frequencyIds: boolean[] = this.fre2id();
  private isChanged: boolean = false;
  fre2id(){
    const frequencyIdArray =this.settingParams?.frequency.split(',').map(item => Number(item));
    const length = frequencyIdArray.length;
    let frequencyIds;
    if (length === 0) {
      frequencyIds = [true, true, true, true, true, true, true]
    }
    else frequencyIds = [1, 2, 3, 4, 5, 6, 7].map(day => frequencyIdArray.includes(day));
    return frequencyIds;

  }
  parseRouterParams() {
    const routerParams: ITaskItem = JSON.parse(router.getParams()['params']);
    // routerParams.frequency.split(',').map(item => {
    //   // 去掉空格并转换为数字
    //   let day = Number(item.trim());
    //
    //   // 有效的 day 范围是 1-7
    //   if(day >= 1 && day <= 7) {
    //     // 在 JavaScript 中，数组的索引是从 0 开始的，所以我们要减去 1
    //     routerParams.frequencyIds[day - 1] = true;
    //   }
    // });
    // Logger.info('Init frequencyIDs'+ routerParams.frequencyIds[2]);
    return routerParams;
  }

  onParamsChanged() {
    this.isChanged = true;
  }

  backIndexParams() {
    return formatParams({
      ...this.settingParams,
      isDone: true,
      finValue: this.settingParams?.targetValue,
    });
  }

  finishTaskEdit() {
    if (this.isChanged) {
      let context: Context = getContext(this) as common.Context;
      addTask({
        id: commonConst.ZERO,
        date: commonConst.GLOBAL_KEY,
        ...this.settingParams,
        isDone: false,
        finValue: ''
      }, context).then(res => {
        globalThis.taskListChange = true;
        router.back({
          url: 'pages/MainPage',
          params: {
            editTask: this.backIndexParams(),
          }
        })
        Logger.info('addTaskFinished', JSON.stringify(res));
      }).catch(error => {
        prompt.showToast({
          message: commonConst.SETTING_FINISH_FAILED_MESSAGE
        })
        Logger.error('addTaskFailed', JSON.stringify(error));
      })
      return;
    }
    router.back({
      url: 'pages/MainPage',
    });
  }

  aboutToAppear() {
    this.broadCast.off(BroadCastType.SHOW_TARGET_SETTING_DIALOG, null);
    this.broadCast.off(BroadCastType.SHOW_REMIND_TIME_DIALOG, null);
    this.broadCast.off(BroadCastType.SHOW_FREQUENCY_DIALOG, null);
  }

  build() {
    Row() {
      Column() {
        List({ space: commonConst.LIST_ITEM_SPACE }) {
          ListItem() {
            TaskChooseItem()
          }
          .listItemStyle()

          ListItem() {
            TargetSetItem()
          }
          .listItemStyle()
          .enabled(
            this.settingParams?.isOpen
          )
          .onClick(() => {
            this.broadCast.emit(
            BroadCastType.SHOW_TARGET_SETTING_DIALOG);
          })

          ListItem() {
            OpenRemindItem()
          }
          .listItemStyle()
          .enabled(this.settingParams?.isOpen)

          ListItem() {
            RemindTimeItem()
          }
          .listItemStyle()
          .enabled(this.settingParams?.isOpen && this.settingParams?.isAlarm)
          .onClick(() => {
            this.broadCast.emit(BroadCastType.SHOW_REMIND_TIME_DIALOG);
          })

          ListItem() {
            FrequencyItem()
          }
          .listItemStyle()
          .enabled(this.settingParams?.isOpen && this.settingParams?.isAlarm)
          .onClick(() => {
            this.broadCast.emit(BroadCastType.SHOW_FREQUENCY_DIALOG);
          })

        }
        .width(commonConst.THOUSANDTH_940)

        Button() {
          Text($r('app.string.complete')).fontSize($r('app.float.default_20')).fontColor($r('app.color.blueColor'))
        }
        .width(commonConst.THOUSANDTH_800)
        .height(commonConst.DEFAULT_48)
        .backgroundColor($r('app.color.borderColor'))
        .onClick(() => {
          this.finishTaskEdit();
        })
        .position({
          x: commonConst.THOUSANDTH_100,
          y: commonConst.THOUSANDTH_800
        })

        TaskDialogView()
      }
      .width(commonConst.THOUSANDTH_1000)
    }
  }
}




