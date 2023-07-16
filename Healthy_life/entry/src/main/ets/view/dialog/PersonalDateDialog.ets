import { FONT_WEIGHT_400, OPACITY_6, OPACITY_4,FULL_WIDTH } from '../../common/constants/CommonConstants';

@Extend(Text) function descStyle () {
  .fontSize($r('app.float.default_14'))
  .fontWeight(FONT_WEIGHT_400)
  .fontFamily($r('app.string.HarmonyHeiTi'))
  .fontColor($r(`app.element.color.titleColor`))
  .width(FULL_WIDTH)
  .lineHeight($r('app.float.default_20'))
  .margin({ top: $r('app.float.default_8') })
}
@CustomDialog
export default struct PersonalDateDialogController {
  @Consume date: string;
  controller: CustomDialogController;
  cancel: () => void;
  name:string = '2021-08-08';
  private selectedDate: Date = new Date('2021-08-08')


  confirm(){
    this.date = this.name;
  }
  build() {
    Column() {
      Text($r('app.string.date'))
        .descStyle()
      DatePicker({
        start: new Date('1970-1-1'),
        end: new Date('2100-1-1'),
        selected: this.selectedDate
      })
        .lunar(false)
        .onChange((value: DatePickerResult) => {
          this.name = value.year.toString()+'-'+(value.month + 1).toString()+'-'+value.day.toString()
        })
      Row() {
        Button($r('app.string.cancel'))
          .backgroundColor(Color.White)
          .fontColor($r('app.color.blueColor'))
          .onClick(() => {
            this.controller.close();
          })
        Divider()
          .vertical(true)
          .height($r('app.float.default_22'))
          .opacity(OPACITY_4)
        Button($r('app.string.sure'))
          .backgroundColor(Color.White)
          .fontColor($r('app.color.blueColor'))
          .onClick(() => {
            this.controller.close();
            this.confirm();
          })
      }
      .width(FULL_WIDTH)
      .margin({ top: $r('app.float.default_22') })
      .justifyContent(FlexAlign.SpaceEvenly)
    }
    .padding($r('app.float.default_16'))
  }
}