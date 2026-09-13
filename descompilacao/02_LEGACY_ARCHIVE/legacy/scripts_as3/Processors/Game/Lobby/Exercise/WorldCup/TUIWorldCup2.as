package Processors.Game.Lobby.Exercise.WorldCup
{
   import Components.Pages.TUIPage;
   import Components.Standard.TUITab;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TWorldCupVo1;
   import Logics.DatebaseVO.VO.TWorldCupVo2;
   import Logics.Exercise.WorldCup.TWorldCup2;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TUIWorldCup2 extends TUIBaseWindow
   {
      
      protected static const ACTIVITY_2_ID:int = 2;
      
      protected static const TAB_COUNT:int = 2;
      
      protected static const ITEM_COUNT:int = 4;
      
      protected var FWorldCup2:TWorldCup2;
      
      protected var FWorldCup1Bin:TBins;
      
      protected var FWorldCup2Bin:TBins;
      
      protected var FCurPageList:Vector.<TWorldCupVo2>;
      
      protected var FMC_Tab:TUITab;
      
      protected var FTabIndex:int;
      
      protected var FUIPage:TUIPage;
      
      protected var FPageIndex:int;
      
      protected var FMC_Bet:MovieClip;
      
      protected var FTF_Input:TextField;
      
      protected var SelectVo:TWorldCupVo2;
      
      protected var BetValue:int;
      
      protected var FCurSelectResult:int;
      
      protected var FBetType:int;
      
      protected var FMC_Competition:MovieClip;
      
      protected var FMC_Result:MovieClip;
      
      protected var FOnBackMain:Function;
      
      public function TUIWorldCup2(param1:TUIComponent)
      {
         super(param1);
         this.FMC_Tab = new TUITab(this);
         this.FUIPage = new TUIPage(this);
         this.FCurPageList = new Vector.<TWorldCupVo2>();
         this.FCurSelectResult = 0;
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         super.Resources_UIDispatch(param1);
         this.FMC_Competition = FMC_Scene["MC_Competition"];
         this.FMC_Result = FMC_Scene["MC_Result"];
         this.FMC_Result.visible = false;
         _loc2_ = 0;
         while(_loc2_ < ITEM_COUNT)
         {
            _loc4_ = this.FMC_Competition["MC_Item" + _loc2_];
            _loc4_.MC_Rate0.MC_Type.gotoAndStop(1);
            _loc4_.MC_Rate1.MC_Type.gotoAndStop(2);
            _loc4_.MC_Rate2.MC_Type.gotoAndStop(3);
            TGameUtil.setButtonMode(_loc4_.BTN_Buy1,true);
            _loc4_.BTN_Buy1.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowBet);
            TGameUtil.setButtonMode(_loc4_.BTN_Buy2,true);
            _loc4_.BTN_Buy2.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowBet);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < TAB_COUNT)
         {
            this.FMC_Tab.SetTabByIndex(FMC_Scene["MC_Tab" + _loc2_],_loc2_);
            _loc2_++;
         }
         this.FMC_Tab.OnSwitch = this.TabOnSwitch;
         this.FMC_Tab.Init();
         this.FUIPage.ButtonPrevious.Substrate = FMC_Scene.MC_ChangePage.MC_PageLeft;
         this.FUIPage.ButtonNext.Substrate = FMC_Scene.MC_ChangePage.MC_PageRight;
         this.FUIPage.LabelPage = FMC_Scene.MC_ChangePage.TF_Page;
         this.FUIPage.PageSize = ITEM_COUNT;
         this.FUIPage.PageIndex = 0;
         this.FPageIndex = 0;
         this.FUIPage.OnChangePage = this.PageOnChange;
         this.FMC_Bet = FMC_Scene["MC_Bet"];
         this.FMC_Bet.visible = false;
         this.FMC_Bet.MC_Rate0.MC_Type.gotoAndStop(1);
         this.FMC_Bet.MC_Rate0.MC_Select.visible = false;
         TGameUtil.setButtonMode(this.FMC_Bet.MC_Rate0,true);
         this.FMC_Bet.MC_Rate0.addEventListener(MouseEvent.CLICK,this.OnResultClick);
         this.FMC_Bet.MC_Rate1.MC_Type.gotoAndStop(2);
         this.FMC_Bet.MC_Rate1.MC_Select.visible = false;
         TGameUtil.setButtonMode(this.FMC_Bet.MC_Rate1,true);
         this.FMC_Bet.MC_Rate1.addEventListener(MouseEvent.CLICK,this.OnResultClick);
         this.FMC_Bet.MC_Rate2.MC_Type.gotoAndStop(3);
         this.FMC_Bet.MC_Rate2.MC_Select.visible = false;
         TGameUtil.setButtonMode(this.FMC_Bet.MC_Rate2,true);
         this.FMC_Bet.MC_Rate2.addEventListener(MouseEvent.CLICK,this.OnResultClick);
         this.FTF_Input = this.FMC_Bet["TF_Input"];
         this.FTF_Input.restrict = "0-9";
         this.FTF_Input.maxChars = 7;
         this.FTF_Input.addEventListener(Event.CHANGE,this.OnTextChange);
         TGameUtil.setButtonMode(this.FMC_Bet.Btn_Ok,true);
         this.FMC_Bet.Btn_Ok.addEventListener(MouseEvent.CLICK,this.ButtonOKOnClick);
         TGameUtil.setButtonMode(this.FMC_Bet.Btn_Cancel,true);
         this.FMC_Bet.Btn_Cancel.addEventListener(MouseEvent.CLICK,this.ButtonCancelOnClick);
         FMC_Scene.Btn_Back.addEventListener(MouseEvent.CLICK,this.ProcessorOnBackMain);
         FMC_Scene.Btn_Recharge.addEventListener(MouseEvent.CLICK,this.ProcessorOnRechargeUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         var _loc3_:int = 0;
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(SLogicsCore.WorldCupDatas.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(SLogicsCore.WorldCupDatas.EndTime) - 1) * 1000)));
         FMC_Scene.TF_GiftGold.text = SLogicsCore.WorldCupDatas.giftGold.toString();
         FMC_Scene.TF_Gold.text = SLogicsCore.WorldCupDatas.gold.toString();
      }
      
      protected function UpdateItem() : void
      {
         if(this.FTabIndex == 0)
         {
            this.FMC_Competition.visible = true;
            this.FMC_Result.visible = false;
            this.UpdateCompetition();
         }
         else
         {
            this.FMC_Competition.visible = false;
            this.FMC_Result.visible = true;
            this.UpdateResult();
         }
      }
      
      protected function UpdateCompetition() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TWorldCupVo1 = null;
         var _loc3_:TWorldCupVo2 = null;
         var _loc4_:MovieClip = null;
         this.GetCurPageDate();
         this.FMC_Competition.TF_Date.text = TUtilityDate.FormatDate(new Date(STimingCore.GetClientShowTime(this.FCurPageList[0].matchday) * 1000));
         _loc1_ = 0;
         while(_loc1_ < ITEM_COUNT)
         {
            _loc4_ = this.FMC_Competition["MC_Item" + _loc1_];
            if(_loc1_ < this.FCurPageList.length)
            {
               _loc4_.visible = true;
               _loc3_ = this.FCurPageList[_loc1_];
               _loc4_.TF_Date.text = TUtilityDate.FormatDate(new Date(STimingCore.GetClientShowTime(_loc3_.matchday) * 1000));
               _loc4_.MC_Flag0.gotoAndStop(_loc3_.hometeam);
               _loc4_.MC_Flag1.gotoAndStop(_loc3_.guestteam);
               _loc2_ = this.FWorldCup1Bin.GetDatebaseByIdentifier(_loc3_.hometeam) as TWorldCupVo1;
               _loc4_.TF_Team0.text = _loc2_.name;
               _loc2_ = this.FWorldCup1Bin.GetDatebaseByIdentifier(_loc3_.guestteam) as TWorldCupVo1;
               _loc4_.TF_Team1.text = _loc2_.name;
               _loc4_.MC_Rate0.MC_Select.visible = false;
               _loc4_.MC_Rate1.MC_Select.visible = false;
               _loc4_.MC_Rate2.MC_Select.visible = false;
               _loc4_.MC_Rate0.TF_Rate.text = (_loc3_.win / 100 as Number).toFixed(2);
               _loc4_.MC_Rate1.TF_Rate.text = (_loc3_.draw / 100 as Number).toFixed(2);
               _loc4_.MC_Rate2.TF_Rate.text = (_loc3_.defeat / 100 as Number).toFixed(2);
            }
            else
            {
               _loc4_.visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function UpdateResult() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TWorldCupVo1 = null;
         var _loc4_:TWorldCupVo2 = null;
         var _loc5_:MovieClip = null;
         var _loc6_:Object = null;
         var _loc7_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < ITEM_COUNT)
         {
            _loc5_ = this.FMC_Result["MC_Item" + _loc1_];
            _loc2_ = _loc1_ + this.FPageIndex * ITEM_COUNT;
            if(_loc2_ < this.FWorldCup2.BetInfo.length)
            {
               _loc5_.visible = true;
               _loc6_ = this.FWorldCup2.BetInfo[_loc2_];
               _loc4_ = this.FWorldCup2Bin.GetDatebaseByIdentifier(_loc6_.id) as TWorldCupVo2;
               _loc5_.TF_Date.text = TUtilityDate.FormatDate(new Date(STimingCore.GetClientShowTime(_loc4_.matchday) * 1000));
               if(_loc6_.result == TWorldCup2.TYPE_DEFEAT)
               {
                  _loc5_.MC_Type0.gotoAndStop(3);
                  _loc5_.TF_Rate.text = (_loc4_.defeat / 100 as Number).toFixed(2);
                  _loc7_ = _loc4_.defeat;
               }
               else if(_loc6_.result == TWorldCup2.TYPE_DRAW)
               {
                  _loc5_.MC_Type0.gotoAndStop(2);
                  _loc5_.TF_Rate.text = (_loc4_.draw / 100 as Number).toFixed(2);
                  _loc7_ = _loc4_.draw;
               }
               else if(_loc6_.result == TWorldCup2.TYPE_WIN)
               {
                  _loc5_.MC_Type0.gotoAndStop(1);
                  _loc5_.TF_Rate.text = (_loc4_.win / 100 as Number).toFixed(2);
                  _loc7_ = _loc4_.win;
               }
               _loc3_ = this.FWorldCup1Bin.GetDatebaseByIdentifier(_loc4_.hometeam) as TWorldCupVo1;
               _loc5_.TF_Team0.text = _loc3_.name;
               _loc3_ = this.FWorldCup1Bin.GetDatebaseByIdentifier(_loc4_.guestteam) as TWorldCupVo1;
               _loc5_.TF_Team1.text = _loc3_.name;
               _loc5_.TF_Score.text = _loc4_.score;
               _loc5_.MC_Type1.visible = _loc4_.results == -1 ? false : true;
               _loc5_.MC_Type1.gotoAndStop(_loc4_.results == 3 ? 1 : (_loc4_.results == 1 ? 2 : 3));
               if(_loc6_.end == 0)
               {
                  _loc5_.MC_Status.gotoAndStop(1);
                  _loc5_.MC_Status.TF_Gold.text = String(_loc6_.gold * 100);
                  _loc5_.MC_Status.MC_Type.gotoAndStop(_loc6_.type);
                  _loc5_.MC_Status.MC_Type.visible = true;
               }
               else if(_loc4_.results != -1 && _loc4_.results == _loc6_.result)
               {
                  _loc5_.MC_Status.gotoAndStop(3);
                  _loc5_.MC_Status.TF_Gold.text = (_loc7_ * _loc6_.gold as Number).toFixed(0);
                  _loc5_.MC_Status.MC_Type.gotoAndStop(_loc6_.type);
                  _loc5_.MC_Status.MC_Type.visible = true;
               }
               else
               {
                  _loc5_.MC_Status.gotoAndStop(2);
                  _loc5_.MC_Status.TF_Gold.text = String(_loc6_.gold * 100);
                  _loc5_.MC_Status.MC_Type.gotoAndStop(_loc6_.type);
                  _loc5_.MC_Status.MC_Type.visible = true;
               }
            }
            else
            {
               _loc5_.visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function UpdatePageInfo() : void
      {
         var _loc1_:TWorldCupVo1 = null;
         var _loc2_:TWorldCupVo2 = null;
         this.FPageIndex = 0;
         if(this.FTabIndex == 0)
         {
            this.FUIPage.TotalQuantity = this.FWorldCup2Bin.Count;
         }
         else
         {
            this.FUIPage.TotalQuantity = this.FWorldCup2.BetInfo.length;
         }
         this.FUIPage.PageIndex = this.FPageIndex;
         this.FUIPage.Update();
      }
      
      protected function GetCurPageDate() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TWorldCupVo2 = null;
         this.FCurPageList.length = 0;
         _loc1_ = 0;
         while(_loc1_ < this.FWorldCup2Bin.Count)
         {
            _loc2_ = this.FWorldCup2Bin.GetDatebaseByIndex(_loc1_) as TWorldCupVo2;
            if(_loc2_.page == this.FPageIndex + 1)
            {
               this.FCurPageList.push(_loc2_);
            }
            _loc1_++;
         }
      }
      
      protected function TabOnSwitch(param1:Object) : void
      {
         this.FTabIndex = param1 as uint;
         this.UpdatePageInfo();
         this.UpdateItem();
      }
      
      protected function PageOnChange(param1:Object, param2:int) : void
      {
         this.FPageIndex = param2;
         this.UpdateCompetition();
         this.UpdateResult();
      }
      
      protected function ProcessorOnShowBet(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         this.FBetType = int(String(param1.currentTarget.name).slice(7));
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         this.SelectVo = this.FCurPageList[_loc2_] as TWorldCupVo2;
         this.FMC_Bet.visible = true;
         this.FTF_Input.text = "";
         this.FCurSelectResult = 0;
         this.FMC_Bet.MC_Rate0.MC_Select.visible = true;
         this.FMC_Bet.MC_Rate1.MC_Select.visible = false;
         this.FMC_Bet.MC_Rate2.MC_Select.visible = false;
         this.FMC_Bet.MC_Rate0.TF_Rate.text = (this.SelectVo.win / 100 as Number).toFixed(2);
         this.FMC_Bet.MC_Rate1.TF_Rate.text = (this.SelectVo.draw / 100 as Number).toFixed(2);
         this.FMC_Bet.MC_Rate2.TF_Rate.text = (this.SelectVo.defeat / 100 as Number).toFixed(2);
      }
      
      protected function OnResultClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(7));
         if(_loc2_ != this.FCurSelectResult)
         {
            this.FMC_Bet["MC_Rate" + this.FCurSelectResult].MC_Select.visible = false;
            this.FMC_Bet["MC_Rate" + _loc2_].MC_Select.visible = true;
            this.FCurSelectResult = _loc2_;
         }
      }
      
      protected function OnTextChange(param1:Event) : void
      {
      }
      
      protected function ButtonOKOnClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = parseInt(this.FTF_Input.text);
         this.FMC_Bet.visible = false;
         if(_loc2_ > 0)
         {
            FOnBuyBox(ACTIVITY_2_ID,TProcessorWorldCup.ACTIVITY_2_BET_RESULT,this.SelectVo.Identifier,this.FBetType,_loc2_ * 100,_loc2_,this.SelectResult);
         }
      }
      
      protected function get SelectResult() : int
      {
         if(this.FCurSelectResult == 0)
         {
            return 3;
         }
         if(this.FCurSelectResult == 1)
         {
            return 1;
         }
         return 0;
      }
      
      protected function ButtonCancelOnClick(param1:MouseEvent) : void
      {
         this.FMC_Bet.visible = false;
      }
      
      protected function ProcessorOnBackMain(param1:MouseEvent) : void
      {
         if(OnShowWindow != null)
         {
            OnShowWindow();
         }
      }
      
      protected function ProcessorOnRechargeUp(param1:MouseEvent) : void
      {
         if(FGotoRecharge != null)
         {
            FGotoRecharge();
         }
      }
      
      protected function ProcessorOnItemOver(param1:Object, param2:Object) : void
      {
         if(FOnItemOver != null)
         {
            FOnItemOver(param1,param2);
         }
      }
      
      protected function ProcessorOnItemOut(param1:Object, param2:Object) : void
      {
         if(FOnItemOut != null)
         {
            FOnItemOut(param1,param2);
         }
      }
      
      protected function ProcessorOnShowRecruit(param1:uint, param2:int) : void
      {
         if(FOnShowRecruit != null)
         {
            FOnShowRecruit(param1,param2);
         }
      }
      
      protected function ProcessorOnLoadLog(param1:MouseEvent) : void
      {
         if(FOnLoadLog != null)
         {
            FOnLoadLog(ACTIVITY_2_ID);
         }
      }
      
      protected function ProcessorOnShowDesc(param1:MouseEvent) : void
      {
         if(FOnShowDesc != null)
         {
            FOnShowDesc();
         }
      }
      
      public function get OnBackMain() : Function
      {
         return this.FOnBackMain;
      }
      
      public function set OnBackMain(param1:Function) : void
      {
         this.FOnBackMain = param1;
      }
      
      override public function Perform_UIDispatch(param1:MovieClip) : void
      {
         super.Perform_UIDispatch(param1);
      }
      
      override public function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         if(FInitialized && this.visible && FMC_Scene.visible && this.FTabIndex == 0)
         {
            _loc1_ = 0;
            while(_loc1_ < this.FCurPageList.length)
            {
               this.FMC_Competition["MC_Item" + _loc1_]["TF_Time"].text = TGameUtil.fomatTime((this.FCurPageList[_loc1_] as TWorldCupVo2).deadline - STimingCore.GetServerTick());
               _loc1_++;
            }
         }
      }
      
      override public function UpdateUI() : void
      {
         this.FWorldCup2 = SLogicsCore.WorldCupDatas.GetActivityByIdentify(ACTIVITY_2_ID) as TWorldCup2;
         this.FWorldCup1Bin = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_WorldCup1);
         this.FWorldCup2Bin = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_WorldCup2);
         this.UpdatePageInfo();
         this.UpdateText();
         this.UpdateItem();
      }
   }
}

