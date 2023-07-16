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

import { TaskMapById } from '../../model/TaskInitList';
import HealthText from '../../view/HealthTextComponent';
import * as commonConst from '../../common/constants/CommonConstants';

@Styles function allSize () {
  .width(commonConst.THOUSANDTH_1000)
  .height(commonConst.THOUSANDTH_1000)
}

@Extend(Text) function labelTextStyle () {
  .fontSize($r('app.float.default_16'))
  .fontWeight(commonConst.FONT_WEIGHT_500)
  .opacity(commonConst.OPACITY_6)
  .fontFamily($r('app.string.HarmonyHeiTi'))
}

@Component
export struct TaskCard {
  @Prop taskInfoStr: string;
  clickAction: (isClick: boolean) => void;

  @Builder targetValueBuilder() {

    if (JSON.parse(this.taskInfoStr).isDone) {
      //如果任务完成,输出已完成文本
      //进度条变暗
      Row() {

        HealthText({
          title: '',
          titleResource: $r('app.string.task_done')
        })

      }

    } else {
      //如果任务未完成,展示完成值或--,然后使用Text组件展示斜杠/、目标值(targetValue属性)
      //进度条显示完成程度
      Row() {

        HealthText({
          title: JSON.parse(this.taskInfoStr).finValue || `--`,
          fontSize: $r('app.float.default_22')
        })
        Text(` / ${JSON.parse(this.taskInfoStr).targetValue} ${TaskMapById[JSON.parse(this.taskInfoStr).taskID].unit}`)
          .labelTextStyle()
          .fontWeight(commonConst.FONT_WEIGHT_400)
      }
    }
  }

  build() {
    Row({ space: commonConst.DEFAULT_6 }) {
      Row({ space: commonConst.DEFAULT_6 }) {
        Image(TaskMapById[JSON.parse(this.taskInfoStr).taskID].icon)
          .width($r('app.float.default_36')).height($r('app.float.default_36'))
          .objectFit(ImageFit.Contain)
        Row(){
          HealthText({
            title: '',
            titleResource: TaskMapById[JSON.parse(this.taskInfoStr).taskID].taskName,
            fontFamily: $r('app.string.HarmonyHeiTi')
          })
        }.width(50)
        Row(){
          if(JSON.parse(this.taskInfoStr).isDone){
            Progress({
              value: 0,
              total: 150,
              type: ProgressType.Capsule
            })
              .color('#c8ba5656')
              .value(150)
              .width('40%')
              .height(10)
          }
          else{
            if(parseInt(JSON.parse(this.taskInfoStr).finValue)<=(parseInt(JSON.parse(this.taskInfoStr).targetValue)/3)) {
              Progress({
                value: 0,
                total: 150,
                type: ProgressType.Capsule
              })
                .value((parseInt(JSON.parse(this.taskInfoStr).finValue)/parseInt(JSON.parse(this.taskInfoStr).targetValue))*150)
                .color('#c9ffe070')
                .backgroundColor('#fffdf4f4')
                .width('40%')
                .height(10)
            }
            else{
              if(parseInt(JSON.parse(this.taskInfoStr).finValue)<=(2*parseInt(JSON.parse(this.taskInfoStr).targetValue))/3) {
                Progress({
                  value: 0,
                  total: 150,
                  type: ProgressType.Capsule
                })
                  .value((parseInt(JSON.parse(this.taskInfoStr).finValue)/parseInt(JSON.parse(this.taskInfoStr).targetValue))*150)
                  .color('#d0ff9232')
                  .backgroundColor('#fffdf4f4')
                  .width('40%')
                  .height(10)
              }
              else {
                Progress({
                  value: 0,
                  total: 150,
                  type: ProgressType.Capsule
                })
                  .value((parseInt(JSON.parse(this.taskInfoStr).finValue)/parseInt(JSON.parse(this.taskInfoStr).targetValue))*150)
                  .color('#bafd5817')
                  .backgroundColor('#fffdf4f4')
                  .width('40%')
                  .height(10)


              }
            }
          }
        }

      }//三个组件

      this.targetValueBuilder();
    }.alignItems(VerticalAlign.Center)
    .allSize()
    .justifyContent(FlexAlign.SpaceBetween)
    .borderRadius($r('app.float.default_24'))
    .padding({ left: commonConst.THOUSANDTH_50, right: commonConst.THOUSANDTH_33 })
    .backgroundColor($r('app.color.white'))
    .onClick(() => this.clickAction(true))
    .gesture(LongPressGesture().onAction(() => this.clickAction(false)))
  }
}