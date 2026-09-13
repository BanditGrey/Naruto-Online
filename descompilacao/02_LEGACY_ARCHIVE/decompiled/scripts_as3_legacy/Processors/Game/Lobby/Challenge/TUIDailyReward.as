package Processors.Game.Lobby.Challenge
{
   import Components.Pages.TUIPage;
   import Foundation.Common.THint;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.Challenge.TChallenge;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrameCopy;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_CHALLENGE;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TUIDailyReward extends TUIBaseWindow
   {
      
      protected static const REWARD_COUNT:int = 5;
      
      protected static const REWARD_ITEM_COUNT:int = 4;
      
      protected var FChallenge:TChallenge;
      
      protected var FUIPage:TUIPage;
      
      protected var FTotalPage:int;
      
      protected var FCurPage:int;
      
      protected var FRewardList:Vector.<TUIShowItem>;
      
      protected var FHelpTips:THint;
      
      public function TUIDailyReward(param1:TUIComponent)
      {
         super(param1);
         this.FChallenge = SLogicsCore.Challenge;
         this.FUIPage = new TUIPage(this);
         this.FHelpTips = new THint();
         this.FRewardList = new Vector.<TUIShowItem>(REWARD_COUNT);
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:TUIShowItem = null;
         super.Resources_UIDispatch(param1);
         this.graphics.beginFill(0,0.6);
         this.graphics.drawRect(0,0,CONST_COMMON.STAGE_Width,CONST_COMMON.STAGE_Height);
         this.graphics.endFill();
         FMC_Scene = param1;
         addChild(FMC_Scene);
         FMC_Scene.x = (FUICore.StageWidth - FMC_Scene.width) / 2;
         FMC_Scene.y = (FUICore.StageHeight - FMC_Scene.height) / 2;
         _loc2_ = 0;
         while(_loc2_ < REWARD_COUNT)
         {
            _loc5_ = new TUIShowItem(this,REWARD_ITEM_COUNT);
            _loc5_.Perform_UIDispatch(FMC_Scene["MC_Item" + _loc2_]);
            _loc5_.OnOverlay = this.ProcessorOnItemOver;
            _loc5_.OnOut = this.ProcessorOnItemOut;
            this.FRewardList[_loc2_] = _loc5_;
            TGameUtil.setButtonMode(FMC_Scene["MC_Item" + _loc2_].BTN_Get,true);
            FMC_Scene["MC_Item" + _loc2_].BTN_Get.addEventListener(MouseEvent.CLICK,this.PrcoessorOnGetUp);
            _loc2_++;
         }
         this.FUIPage.ButtonPrevious.Substrate = FMC_Scene.MC_ChangePage.MC_PageLeft;
         this.FUIPage.ButtonNext.Substrate = FMC_Scene.MC_ChangePage.MC_PageRight;
         this.FUIPage.LabelPage = FMC_Scene.MC_ChangePage.TF_Page;
         this.FUIPage.TotalQuantity = this.FTotalPage;
         this.FUIPage.PageSize = REWARD_COUNT;
         this.FUIPage.PageIndex = 0;
         this.FCurPage = 0;
         this.FUIPage.OnChangePage = this.ProcessorPageOnChange;
         FMC_Scene.BTN_Close.addEventListener(MouseEvent.CLICK,this.OnCloseMain);
         FMC_Scene.BTN_Help.addEventListener(MouseEvent.MOUSE_MOVE,this.ButtonHelpOnOver);
         FMC_Scene.BTN_Help.addEventListener(MouseEvent.ROLL_OUT,this.ButtonHelpOnOut);
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TBaseBox = null;
         var _loc5_:String = null;
         this.FUIPage.TotalQuantity = this.FChallenge.DailyReward.length;
         this.FUIPage.Update();
         _loc1_ = 0;
         while(_loc1_ < REWARD_COUNT)
         {
            _loc3_ = FMC_Scene["MC_Item" + _loc1_];
            _loc2_ = _loc1_ + this.FCurPage * REWARD_COUNT;
            if(_loc2_ < this.FChallenge.DailyReward.length)
            {
               _loc3_.visible = true;
               _loc4_ = this.FChallenge.DailyReward[_loc2_];
               this.FRewardList[_loc1_].UpdateUI(_loc4_.Inventories);
               _loc5_ = new ConsumeFrameCopy(STRING_CHALLENGE.STRING_001).DescribeString;
               _loc3_.TF_Desc.text = TUtilityString.Format(_loc5_,_loc4_.Count);
               if(_loc4_.Status == TBaseActivity.STATUS_CANNOTGET)
               {
                  _loc3_.MC_Got.visible = false;
                  _loc3_.BTN_Get.visible = true;
                  TGameUtil.setButtonMode(_loc3_.BTN_Get,false);
               }
               else if(_loc4_.Status == TBaseActivity.STATUS_CANGET)
               {
                  _loc3_.MC_Got.visible = false;
                  _loc3_.BTN_Get.visible = true;
                  TGameUtil.setButtonMode(_loc3_.BTN_Get,true);
               }
               else
               {
                  _loc3_.MC_Got.visible = true;
                  _loc3_.BTN_Get.visible = false;
               }
            }
            else
            {
               _loc3_.visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function ProcessorPageOnChange(param1:Object, param2:int) : void
      {
         this.FCurPage = param2;
         this.UpdateBox();
      }
      
      protected function OnCloseMain(param1:MouseEvent) : void
      {
         if(FOnCloseWindow != null)
         {
            FOnCloseWindow(this);
         }
      }
      
      protected function PrcoessorOnGetUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         _loc3_ = _loc2_ + this.FCurPage * REWARD_COUNT;
         if(FOnGetBox != null)
         {
            FOnGetBox(TProcessorChallenge.REQ_TYPE_GER_DAILY_REWARD,this.FChallenge.DailyReward[_loc3_].Identify);
         }
      }
      
      protected function ButtonHelpOnOver(param1:MouseEvent) : void
      {
         var _loc2_:TSystemLanguage = null;
         if(OnHelpOver != null)
         {
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.HELPTIPS_70170102) as TSystemLanguage;
            this.FHelpTips.Content = _loc2_.Desc;
            OnHelpOver(this,this.FHelpTips);
         }
      }
      
      protected function ButtonHelpOnOut(param1:MouseEvent) : void
      {
         if(OnHelpOut != null)
         {
            OnHelpOut(this);
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
      
      override public function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         if(FInitialized && this.visible && FMC_Scene.visible)
         {
            _loc1_ = 0;
            while(_loc1_ < this.FRewardList.length)
            {
               this.FRewardList[_loc1_].LogicsPerform();
               _loc1_++;
            }
         }
      }
      
      public function UpdateWindow() : void
      {
         this.UpdateBox();
      }
      
      override public function Unmount() : void
      {
      }
   }
}

