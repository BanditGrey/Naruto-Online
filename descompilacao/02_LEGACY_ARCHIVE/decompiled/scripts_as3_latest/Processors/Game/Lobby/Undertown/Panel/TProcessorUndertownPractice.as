package Processors.Game.Lobby.Undertown.Panel
{
   import Components.Pages.TUIPage;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.TongLing.ToolS.Tools_Help;
   import Processors.Game.Lobby.Undertown.CellPanel.PracticeListCell;
   import Processors.Game.Lobby.Undertown.CellPanel.RewardListCell;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorUndertownPractice extends TProcessorLobbyWindow
   {
      
      public static const TEN:int = 10;
      
      public static const THREE:int = 4;
      
      protected var FMainUI:Sprite;
      
      protected var FUIPage1:TUIPage;
      
      protected var FUIPage2:TUIPage;
      
      protected var FCurPage1:int;
      
      protected var FCurPage2:int;
      
      protected var FPracticeList:Vector.<PracticeListCell>;
      
      protected var FRewardList:Vector.<RewardListCell>;
      
      protected var FBtn_Close:SimpleButton;
      
      protected var FMC_OpenFriend:MovieClip;
      
      protected var FMC_GetRewardArea:MovieClip;
      
      protected var FBTN_Add:SimpleButton;
      
      protected var FTF_Value:TextField;
      
      protected var FCurOpenIndex:int;
      
      protected var FGetRewardBtnBackFunction:Function;
      
      protected var FBackFunction:Function;
      
      protected var FBuyCountFunction:Function;
      
      protected var FOccupyBtnOnOver:Function;
      
      protected var FOccupyBtnOnOut:Function;
      
      protected var FCurRewardBtnForDiaoLuoTian:uint;
      
      public function TProcessorUndertownPractice(param1:TUIComponent)
      {
         super(param1);
         this.graphics.beginFill(0,0.3);
         this.graphics.drawRect(-(FUICore.StageWidth / 2),-(FUICore.StageHeight / 2),FUICore.StageWidth * 2,FUICore.StageHeight * 2);
         this.graphics.endFill();
         this.FUIPage1 = new TUIPage(this);
         this.FUIPage2 = new TUIPage(this);
         this.FPracticeList = new Vector.<PracticeListCell>(TEN);
         this.FRewardList = new Vector.<RewardListCell>(THREE);
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:int = 0;
         var _loc5_:PracticeListCell = null;
         var _loc6_:RewardListCell = null;
         this.FMainUI = TUtilityReflection.CreateDisplayObjectInstance("MC_UndertownPractice") as Sprite;
         this.FMainUI.x = (FUICore.StageWidth - this.FMainUI.width) / 2;
         this.FMainUI.y = (FUICore.StageHeight - this.FMainUI.height) / 2;
         addChild(this.FMainUI);
         this.FBtn_Close = this.FMainUI["Btn_Close"];
         new Tools_Help(this,this.FMainUI["Btn_Help"],CONST_SYSTEMLANGUAGE.HELPTIPS_777777_3,FUICore);
         this.FMC_OpenFriend = this.FMainUI["MC_PracticeOpenOrClose"]["MC_OpenFriend"];
         this.FMC_GetRewardArea = this.FMainUI["MC_GetRewardArea"];
         this.FBTN_Add = this.FMainUI["MC_ShengYuTianCishu"]["BTN_Add"];
         this.FTF_Value = this.FMainUI["MC_ShengYuTianCishu"]["TF_Value"];
         TGameUtil.setButtonMode(this.FMC_OpenFriend,true);
         this.FUIPage1.ButtonPrevious.Substrate = this.FMainUI["MC_ChangePage"]["MC_PageLeft"];
         this.FUIPage1.ButtonNext.Substrate = this.FMainUI["MC_ChangePage"]["MC_PageRight"];
         this.FUIPage1.LabelPage = this.FMainUI["MC_ChangePage"]["TF_Page"];
         this.FUIPage1.PageSize = TEN;
         this.FUIPage1.PageIndex = 0;
         this.FCurPage1 = 0;
         this.FUIPage1.OnChangePage = this.ProcessorPageOnChange1;
         this.FUIPage2.ButtonPrevious.Substrate = this.FMainUI["MC_GetRewardArea"]["MC_ChangePage"]["MC_PageLeft"];
         this.FUIPage2.ButtonNext.Substrate = this.FMainUI["MC_GetRewardArea"]["MC_ChangePage"]["MC_PageRight"];
         this.FUIPage2.LabelPage = this.FMainUI["MC_GetRewardArea"]["MC_ChangePage"]["TF_Page"];
         this.FUIPage2.PageSize = THREE;
         this.FUIPage2.PageIndex = 0;
         this.FCurPage2 = 0;
         this.FUIPage2.OnChangePage = this.ProcessorPageOnChange2;
         _loc4_ = 0;
         while(_loc4_ < TEN)
         {
            _loc5_ = new PracticeListCell();
            _loc5_.MainUI = this.FMainUI["MC_PracticeCell_" + _loc4_];
            _loc5_.GetRewardBtnBackFunction = this.Cao;
            _loc5_.OccupyBtnOnOver = this.ProcessorOccupyBtnOnOver;
            _loc5_.OccupyBtnOnOut = this.ProcessorOccupyBtnOnOut;
            _loc5_.MainUI.gotoAndStop(_loc4_ % 2 + 1);
            this.FPracticeList[_loc4_] = _loc5_;
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < THREE)
         {
            _loc6_ = new RewardListCell();
            _loc6_.MainUI = this.FMainUI["MC_GetRewardArea"]["MC_GetReward_" + _loc4_];
            _loc6_.BackFunction = this.NiMei;
            this.FRewardList[_loc4_] = _loc6_;
            _loc4_++;
         }
         super.ResourcesPerform_UIDispatch();
      }
      
      public function set BackFunction(param1:Function) : void
      {
         this.FBackFunction = param1;
      }
      
      protected function NiMei(param1:uint) : void
      {
         if(this.FBackFunction != null)
         {
            this.FCurRewardBtnForDiaoLuoTian = param1;
            this.FBackFunction(param1);
         }
      }
      
      protected function Cao(param1:uint, param2:int) : void
      {
         if(this.FGetRewardBtnBackFunction != null)
         {
            this.FGetRewardBtnBackFunction(param1,param2);
         }
      }
      
      protected function ProcessorOccupyBtnOnOver(param1:String) : void
      {
         if(this.FOccupyBtnOnOver != null)
         {
            this.FOccupyBtnOnOver(param1);
         }
      }
      
      protected function ProcessorOccupyBtnOnOut() : void
      {
         if(this.FOccupyBtnOnOut != null)
         {
            this.FOccupyBtnOnOut();
         }
      }
      
      public function set GetRewardBtnBackFunction(param1:Function) : void
      {
         this.FGetRewardBtnBackFunction = param1;
      }
      
      public function UpdateCount() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = SLogicsCore.UndertownLogicData.BuyCount + SLogicsCore.UndertownLogicData.DefaultCount;
         _loc1_ = uint(SLogicsCore.UndertownLogicData.CostCount);
         if(_loc2_ <= _loc1_)
         {
            _loc2_ = 0;
         }
         else
         {
            _loc2_ -= _loc1_;
         }
         this.FTF_Value.text = _loc2_.toString();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBtn_Close.addEventListener(MouseEvent.CLICK,this.CloseClick);
         this.FMC_OpenFriend.addEventListener(MouseEvent.CLICK,this.CloseClick);
         this.FBTN_Add.addEventListener(MouseEvent.CLICK,this.CloseClick);
         this.OpenOrCloseLittlePanel();
         super.ResourcesPerform_UILocations();
      }
      
      public function UpdateRewardList() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = int(SLogicsCore.UndertownLogicData.UndertownRewardListDataVector.length);
         if(_loc3_ > 0)
         {
            this.FMainUI["MC_PracticeOpenOrClose"]["MC_EffectMovie"].visible = true;
         }
         else
         {
            this.FMainUI["MC_PracticeOpenOrClose"]["MC_EffectMovie"].visible = false;
         }
         _loc1_ = 0;
         while(_loc1_ < THREE)
         {
            _loc2_ = _loc1_ + this.FCurPage2 * THREE;
            if(_loc2_ >= _loc3_)
            {
               this.FRewardList[_loc1_].MainUI.visible = false;
            }
            else
            {
               this.FRewardList[_loc1_].MainUI.visible = true;
               this.FRewardList[_loc1_].RewardListData = SLogicsCore.UndertownLogicData.UndertownRewardListDataVector[_loc2_];
               this.FRewardList[_loc1_].UpdateView();
            }
            _loc1_++;
         }
      }
      
      protected function UpdatePracticeList() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = int(SLogicsCore.UndertownLogicData.UndertownPracticeListDataVector.length);
         _loc1_ = 0;
         while(_loc1_ < TEN)
         {
            _loc2_ = _loc1_ + this.FCurPage1 * TEN;
            if(_loc2_ >= _loc3_)
            {
               this.FPracticeList[_loc1_].MainUI.visible = false;
            }
            else
            {
               this.FPracticeList[_loc1_].MainUI.visible = true;
               this.FPracticeList[_loc1_].PracticeListData = SLogicsCore.UndertownLogicData.UndertownPracticeListDataVector[_loc2_];
               this.FPracticeList[_loc1_].UpdateView();
            }
            _loc1_++;
         }
      }
      
      public function GetRewardBack() : void
      {
         SLogicsCore.UndertownLogicData.UndertownRewardListDeleteDataByTime(this.FCurRewardBtnForDiaoLuoTian);
         this.UpdateTotalQuantity2();
         this.UpdateRewardList();
      }
      
      protected function UpdateTotalQuantity1() : void
      {
         this.FCurPage1 = 0;
         this.FUIPage1.PageIndex = this.FCurPage1;
         this.FUIPage1.TotalQuantity = SLogicsCore.UndertownLogicData.UndertownPracticeListDataVector.length;
         this.FUIPage1.Update();
         this.FCurPage1 = 0;
      }
      
      public function UpdateTotalQuantity2() : void
      {
         this.FCurPage2 = 0;
         this.FUIPage2.PageIndex = this.FCurPage2;
         this.FUIPage2.TotalQuantity = SLogicsCore.UndertownLogicData.UndertownRewardListDataVector.length;
         this.FUIPage2.Update();
      }
      
      public function OpenThisPanel() : void
      {
         this.UpdateTotalQuantity1();
         this.UpdateTotalQuantity2();
         this.UpdatePracticeList();
         this.UpdateRewardList();
         this.UpdateCount();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         if(!Visible)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < TEN)
         {
            this.FPracticeList[_loc1_].LogicsPerform();
            _loc1_++;
         }
         super.LogicsPerform();
      }
      
      protected function ProcessorPageOnChange1(param1:Object, param2:int) : void
      {
         this.FCurPage1 = param2;
         this.UpdatePracticeList();
      }
      
      protected function ProcessorPageOnChange2(param1:Object, param2:int) : void
      {
         this.FCurPage2 = param2;
         this.UpdateRewardList();
      }
      
      protected function CloseClick(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FBtn_Close:
               this.Visible = false;
               SLogicsCore.UndertownLogicData.NextWillOpenPanelIndex = 0;
               break;
            case this.FMC_OpenFriend:
               this.FCurOpenIndex = this.FCurOpenIndex == 0 ? 1 : 0;
               this.OpenOrCloseLittlePanel();
               break;
            case this.FBTN_Add:
               if(this.FBuyCountFunction != null)
               {
                  this.FBuyCountFunction();
               }
         }
      }
      
      protected function OpenOrCloseLittlePanel() : void
      {
         if(this.FCurOpenIndex == 0)
         {
            this.FMC_GetRewardArea.visible = false;
            this.FMainUI.x += this.FMC_GetRewardArea.width / 2;
         }
         else
         {
            this.FMC_GetRewardArea.visible = true;
            this.FMainUI.x -= this.FMC_GetRewardArea.width / 2;
         }
      }
      
      public function set BuyCountFunction(param1:Function) : void
      {
         this.FBuyCountFunction = param1;
      }
      
      public function get OccupyBtnOnOver() : Function
      {
         return this.FOccupyBtnOnOver;
      }
      
      public function set OccupyBtnOnOver(param1:Function) : void
      {
         this.FOccupyBtnOnOver = param1;
      }
      
      public function get OccupyBtnOnOut() : Function
      {
         return this.FOccupyBtnOnOut;
      }
      
      public function set OccupyBtnOnOut(param1:Function) : void
      {
         this.FOccupyBtnOnOut = param1;
      }
   }
}

