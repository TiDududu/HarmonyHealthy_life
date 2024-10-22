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
import common from '@ohos.app.ability.common';
import Logger from '../common/utils/Logger';
import { ITaskItem } from '../model/TaskInitList';
import * as commonConst from '../common/constants/CommonConstants';
import { NavList, TabId } from '../model/NavItemModel';
import HomeIndex from '../view/HomeComponent';
import { AchievementIndex } from '../view/AchievementComponent';
import { MineIndex } from './MinePage';
import { HomeStore } from '../viewmodel/HomeViewModel';
import GlobalInfoApi from '../common/database/tables/GlobalInfoApi';
import { NICK_NAME, SIGNATURE, FULL_HEIGHT } from '../common/constants/CommonConstants';
import data_preferences from '@ohos.data.preferences';
import { getBadgeCardItems ,getBadgeCardItems_single } from '../viewmodel/AchievementViewModel'
import { ACHIEVEMENT_LEVEL_KEY ,ACHIEVEMENT_LEVEL_KEY_SINGLE } from '../model/AchieveModel'

@Styles function allSize() {
  .width(commonConst.THOUSANDTH_1000)
  .height(commonConst.THOUSANDTH_1000)
}

@Entry
@Component
struct Index {
  context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext;
  @State currentPage: number = 0;
  @State editedTaskInfo: ITaskItem = JSON.parse(router.getParams() ? router.getParams()['editTask'] : '{}');
  @State editedTaskID: string = '0';
  @State homeStore: HomeStore = new HomeStore(new Date());
  @State nickname: string = NICK_NAME;
  @State signature: string = SIGNATURE;
  @State image: string = 'app.media.ic_user';
  // @State BadgeCardItems_single:[string, Resource][] = getBadgeCardItems_single(0);
  // @StorageProp(ACHIEVEMENT_LEVEL_KEY_SINGLE) successiveTimes: number = 0;
  private tabController: TabsController = new TabsController();

  onPageShow() {
    Logger.info('onPageShow', JSON.stringify(router.getParams()));
    this.editedTaskInfo = JSON.parse(router.getParams() ? router.getParams()['editTask'] : '{}');
    this.editedTaskID = JSON.stringify(this.editedTaskInfo);
    if (globalThis.isForeground) {
      globalThis.isForeground = false;
      if (this.homeStore.currentDate.getDate() !== (new Date()).getDate()) {
        globalThis.taskListChange = true;
        this.homeStore = new HomeStore(new Date());
      }
      this.checkCurrentTime();
    }
    this.MineIndexDate()
    // this.BadgeCardItems_single = getBadgeCardItems_single(this.successiveTimes);
  }
  MineIndexDate(){
    let preferences = data_preferences.getPreferences(this.context, "PersonalData");
    globalThis.context =this.context
    preferences.then((res)=>{
      if (res.has("image")) {
        res.get("image", 'app.media.ic_user').then((value) => {
          this.image = value.toString();
          Logger.info('PersonalData', 'image is get success');
        }).catch((err) => {
          Logger.info('PersonalData', 'image get failed. Cause:' + err);
        });
      }
      if (res.has("nickname")) {
        res.get("nickname", NICK_NAME).then((value) => {
          this.nickname = value.toString();
          Logger.info('PersonalData', 'nickname is get success');
        }).catch((err) => {
          Logger.info('PersonalData', 'nickname get failed. Cause:' + err);
        });
      }
      if (res.has("signature")) {
        res.get("signature", SIGNATURE).then((value) => {
          this.signature = value.toString();
          Logger.info('PersonalData', 'signature is get success');
        }).catch((err) => {
          Logger.info('PersonalData', 'signature get failed. Cause:' + err);
        });
      }
    })
  }
  checkCurrentTime() {
    GlobalInfoApi.query((result) => {
      let predate = new Date(result.lastDate);
      let date = new Date();
      if (result.length !== 0 && date.getTime() < predate.getTime()) {
        AlertDialog.show(
          {
            title: $r('app.string.alert'),
            message: $r('app.string.alert_message'),
            autoCancel: false,
            alignment: DialogAlignment.Bottom,
            offset: { dx: 0, dy: -20 },
            gridCount: 3,
            confirm: {
              value: $r('app.string.alert_button'),
              action: () => {
                (getContext(this) as common.UIAbilityContext).terminateSelf();
                console.info('Button-clicking callback');
              }
            },
            cancel: () => {
              console.info('Closed callbacks');
            }
          });
      } else {
        this.homeStore.initData();
      }
    });
  }

  @Builder TabBuilder(index: number) {
    Column() {
      Image(index === this.currentPage ? NavList[index].icon_selected : NavList[index].icon)
        .width($r('app.float.default_24'))
        .height($r('app.float.default_24'))
        .objectFit(ImageFit.Contain);
      Text(NavList[index].text)
        .fontSize($r('app.float.default_10'))
        .fontWeight(commonConst.FONT_WEIGHT_500)
        .fontColor(this.currentPage === index ? $r('app.color.blueColor') : $r('app.color.tabTitleColor'))
        .margin({ top: $r('app.float.default_4') })
    }.justifyContent(FlexAlign.Center).allSize()
  }

  build() {
    Tabs({ barPosition: BarPosition.End, controller: this.tabController }) {
      TabContent() {
        HomeIndex({ homeStore: $homeStore, editedTaskInfo: $editedTaskInfo, editedTaskID: $editedTaskID })
          .borderWidth({ bottom: 1 })
          .borderColor($r('app.color.primaryBgColor'))
      }
      .tabBar(this.TabBuilder(TabId.HOME))
      .align(Alignment.Start)

      TabContent() {
        AchievementIndex()
      }
      .tabBar(this.TabBuilder(TabId.ACHIEVEMENT))

      TabContent() {
        MineIndex({nickname: $nickname, signature: $signature, image: $image})
          .borderWidth({ bottom: 1 })
          .borderColor($r('app.color.primaryBgColor'))
      }
      .tabBar(this.TabBuilder(TabId.MINE))
    }
    .scrollable(false)
    .allSize()
    .barWidth(commonConst.THOUSANDTH_940)
    .barMode(BarMode.Fixed)
    .vertical(false)
    .animationDuration(400)
    .onChange((index) => {
      this.currentPage = index;
    })
  }
}