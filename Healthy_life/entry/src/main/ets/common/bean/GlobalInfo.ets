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

/**
 * GlobalInfo
 *
 * @param firstDate
 * @param lastDate
 * @param checkInDays
 * @param achievements
 */
export default class GlobalInfo {
    firstDate: string;
    lastDate: string;
    checkInDays: number;
    achievements: string;

    //增加单项任务成就
    achievements_single: string;
    //增加单项成就次数
    finish_time: number;

    constructor(firstDate: string, lastDate: string, checkInDays: number, achievements: string , achievements_single:string , finish_time:number) {
        this.firstDate = firstDate;
        this.lastDate = lastDate;
        this.checkInDays = checkInDays;
        this.achievements = achievements;

        //新增单项任务
        this.achievements_single = achievements_single;

        //新增单项完成次数
        this.finish_time = finish_time;
    }
}