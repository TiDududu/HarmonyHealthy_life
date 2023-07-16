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

import { ListInfo } from '../view/ListInfo';
import { UserBaseInfo } from '../view/UserBaseInfo';
import { NICK_NAME, SIGNATURE, FULL_HEIGHT } from '../common/constants/CommonConstants';
import common from '@ohos.app.ability.common';
@Component
export struct MineIndex {
  context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext;
  @Link image: string;
  @Link nickname: string;
  @Link signature: string;


  build() {
    Column() {
      UserBaseInfo({
        image: this.image,
        nickname: this.nickname,
        signature: this.signature
      });

      ListInfo({nickname: $nickname, signature: $signature});
    }
    .height(FULL_HEIGHT)
    .backgroundColor($r('app.color.mineBgColor'))
  }
}