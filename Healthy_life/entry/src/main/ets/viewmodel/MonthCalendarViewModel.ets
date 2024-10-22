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

import { WeekDateModel } from '../model/WeekCalendarModel';
import Logger from '../common/utils/Logger';
import { WEEK_DAY_NUM, WEEK_DAY_TIME } from '../common/constants/CommonConstants';
import { MONTH_DAY_NUM,MONTH_DAY_TIME} from '../common/constants/CommonConstants';

function gotoPreviousMonth() {
  this.isPageScroll = true;
  let date: Date = new Date(this.homeStore.showDate);
  Logger.info('HomeIndex', 'gotoPreviousMonth: showDate_' + date.toISOString());

  let new_showDate=new Date(this.homeStore.showDate);
  new_showDate.setDate(0);
  this.homeStore.getPreMonthData(date, () => {
    this.homeStore.setSelectedShowDate(new_showDate.getTime());
    this.currentPage += 1;
  });
  this.scroller.scrollPage({ next: false });
  Logger.info('HomeIndex', 'gotoPreviousMonth');
  //this.homeStore.setSelectedShowDate(this.homeStore.showDate - WEEK_DAY_TIME);
}

function goToNextMonth() {
  if (this.currentPage <= 1) {
    Logger.info('HomeIndex', 'goToNextMonth: is the current month');
    return;
  }
  this.isPageScroll = true;
  Logger.info('HomeIndex', 'goToNextMonth: nextPage');

  let date: Date = new Date(this.homeStore.showDate);
  let new_showDate=new Date(this.homeStore.showDate);
  new_showDate.setDate(32);

  this.homeStore.getNextMonthData(date, () => {
    this.homeStore.setSelectedShowDate(new_showDate.getTime());
    this.currentPage -= 1;
  });
  this.scroller.scrollPage({ next: true });
}

function onScrollEndAction() {
  if (!this.isPageScroll) {
    let page = Math.round(this.scroller.currentOffset().xOffset / this.scrollWidth);
    page = this.isLoadMore ? page + 1 : page;
    if (this.scroller.currentOffset().xOffset % this.scrollWidth != 0 || this.isLoadMore) {
      let xOffset = page * this.scrollWidth;
      this.scroller.scrollTo({ xOffset, yOffset: 0 });
      this.isLoadMore = false;
    }
    let dayModel = this.homeStore.weekArr[2][0];
    //let aaaa = (this.homeStore.currentDate.getFullYear()-dayModel.getFullYear())*12+(this.homeStore.currentDate.getMonth()-dayModel.getMonth()) - page - 1;
    Logger.info('HomeIndex', 'onScrollEnd: page ' + page + ', listLength ' + this.homeStore.dateArr.length);
    Logger.info('HomeIndex', 'currentItem: ' + JSON.stringify(dayModel) + ', selectedDay  ' + this.homeStore.selectedDay);
    this.homeStore.setSelectedShowDate(dayModel.date.getTime());
  }
  this.isPageScroll = false;
}

function onScrollEdgeAction(side: Edge) {
  if (side == Edge.Top && !this.isPageScroll) {
    Logger.info('HomeIndex', 'onScrollEdge: currentPage ' + this.currentPage);
    Logger.info('HomeIndex', 'onScrollEdge: load more data');
    let date: Date = new Date(this.homeStore.showDate);
    date.setDate(0);
    this.homeStore.getNextMonthData(date,()=>{});
    this.isLoadMore = true;

  }
}

function calenderItemClickAction(item: WeekDateModel, index: number) {
  Logger.info('HomeIndex', 'click the calendarItem: ' + JSON.stringify(item));
  this.homeStore.setSelectedShowDate(item.date.getTime());
  this.homeStore.selectedDay = index % WEEK_DAY_NUM;
}

const MonthCalendarMethods = {
  gotoPreviousMonth,
  goToNextMonth,
  onScrollEndAction,
  onScrollEdgeAction,
  calenderItemClickAction,
}

export default MonthCalendarMethods;