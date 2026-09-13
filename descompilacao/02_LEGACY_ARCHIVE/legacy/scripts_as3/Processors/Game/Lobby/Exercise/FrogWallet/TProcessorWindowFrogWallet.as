package Processors.Game.Lobby.Exercise.FrogWallet
{
   import Components.Slots.TUISlot;
   import Externals.SExternalCore;
   import Foundation.Common.THint;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.FrogWallet.TCornucopia;
   import Logics.Exercise.FrogWallet.TRechargeAccum;
   import Logics.Exercise.FrogWallet.TShadow;
   import Logics.Exercise.TBaseActivity;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Exercise.FrogWallet.Components.TUICornucopia;
   import Processors.Game.Lobby.Exercise.FrogWallet.Components.TUIRechargeAccum;
   import Processors.Game.Lobby.Exercise.FrogWallet.Components.TUIShadow;
   import Processors.Game.Lobby.Exercise.FrogWallet.Components.TUITenTail;
   import Resources.Constants.CONST_FROGWALLET;
   import Resources.Constants.CONST_MODULES;
   import Resources.Strings.STRING_FROGWALLET;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowFrogWallet extends TProcessorLobbyWindow
   {
      
      public static const REWARD_COUNT:int = 6;
      
      public static const ACTIVITY_1_ID:int = CONST_FROGWALLET.ACTIVITY_1_ID;
      
      public static const ACTIVITY_2_ID:int = CONST_FROGWALLET.ACTIVITY_2_ID;
      
      public static const ACTIVITY_3_ID:int = CONST_FROGWALLET.ACTIVITY_3_ID;
      
      public static const ACTIVITY_4_ID:int = CONST_FROGWALLET.ACTIVITY_4_ID;
      
      public static const INIT_X:int = 193;
      
      public static const INIT_Y:int = 58;
      
      public static const RESULT_LOSE:int = TShadow.RESULT_LOSE;
      
      public static const RESULT_NOCHANGE:int = TShadow.RESULT_NOCHANGE;
      
      public static const RESULT_WIN:int = TShadow.RESULT_WIN;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FMC_Title:MovieClip;
      
      protected var FTF_Title:TextField;
      
      protected var FMC_Background:MovieClip;
      
      protected var FMC_Context:Sprite;
      
      protected var FMC_Text:MovieClip;
      
      protected var FTF_Date:TextField;
      
      protected var FTF_Detail:TextField;
      
      protected var FTF_Time:TextField;
      
      protected var FBTN_Goto:SimpleButton;
      
      protected var FSlotList:Vector.<TUISlot>;
      
      protected var FInitialized:Boolean;
      
      protected var FChangeTabIndex:int;
      
      protected var FWindowsList:Vector.<TUIComponent>;
      
      protected var FUICornucopia:TUICornucopia;
      
      protected var FUIRechargeAccum:TUIRechargeAccum;
      
      protected var FUITenTail:TUITenTail;
      
      protected var FUIShadow:TUIShadow;
      
      protected var FOnOverlay:Function;
      
      protected var FOnOut:Function;
      
      protected var FTipOnOver:Function;
      
      protected var FTipOnOut:Function;
      
      protected var FOnGoto:Function;
      
      protected var FOnGetReward:Function;
      
      protected var FEffectText:Function;
      
      protected var FOnShowPackage:Function;
      
      protected var FOnStartPractice:Function;
      
      protected var FOnShadowGetReward:Function;
      
      public function TProcessorWindowFrogWallet(param1:TUIComponent)
      {
         super(param1);
         this.FSlotList = new Vector.<TUISlot>();
         this.FWindowsList = new Vector.<TUIComponent>();
      }
      
      protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         this.FMC_Scene = param1;
         addChild(this.FMC_Scene);
         this.Resources_UIDispatchContext();
         this.Resources_UIDispatchWindow();
      }
      
      protected function Resources_UIDispatchContext() : void
      {
         this.FMC_Title = this.FMC_Scene[CONST_FROGWALLET.RESOURCE_LINK_MC_TITLE];
         this.FTF_Title = this.FMC_Title[CONST_FROGWALLET.RESOURCE_LINK_TF_TITLE];
         this.FMC_Background = this.FMC_Title[CONST_FROGWALLET.RESOURCE_LINK_MC_Background];
         this.FMC_Context = this.FMC_Scene[CONST_FROGWALLET.RESOURCE_LINK_MC_Context];
         this.FMC_Text = this.FMC_Context[CONST_FROGWALLET.RESOURCE_LINK_MC_TEXT];
         this.FTF_Date = this.FMC_Text[CONST_FROGWALLET.RESOURCE_LINK_TF_DATE];
         this.FTF_Detail = this.FMC_Text[CONST_FROGWALLET.RESOURCE_LINK_TF_DETAIL];
         this.FTF_Time = this.FMC_Context[CONST_FROGWALLET.RESOURCE_LINK_TF_TIME];
         this.FBTN_Goto = this.FMC_Context[CONST_FROGWALLET.RESOURCE_LINK_BTN_GOTO];
      }
      
      protected function Resources_UIDispatchWindow() : void
      {
         this.FUICornucopia = new TUICornucopia(this);
         this.FUICornucopia.Perform_UIDispatch(this.FMC_Context[CONST_FROGWALLET.RESOURCE_LINK_MC_Activity1]);
         this.FUICornucopia.X = INIT_X;
         this.FUICornucopia.Y = INIT_Y;
         this.FUICornucopia.OnOverlay = this.SlotsOnOver;
         this.FUICornucopia.OnOut = this.SlotsOnOut;
         this.FUICornucopia.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
         this.FUICornucopia.OnGetReward = this.ProcessorOnGetReward;
         this.FUICornucopia.EffectText = this.ProcessorEffectText;
         this.FUICornucopia.TipOnOver = this.ProcessorTipOnOver;
         this.FUICornucopia.TipOnOut = this.ProcessorTipOnOut;
         this.FUICornucopia.Visible = false;
         this.FWindowsList.push(this.FUICornucopia);
         this.FUIRechargeAccum = new TUIRechargeAccum(this);
         this.FUIRechargeAccum.Perform_UIDispatch(this.FMC_Context[CONST_FROGWALLET.RESOURCE_LINK_MC_Activity2]);
         this.FUIRechargeAccum.OnGetReward = this.ProcessorOnGetReward;
         this.FUIRechargeAccum.EffectText = this.ProcessorEffectText;
         this.FUIRechargeAccum.X = INIT_X;
         this.FUIRechargeAccum.Y = INIT_Y;
         this.FUIRechargeAccum.Visible = false;
         this.FWindowsList.push(this.FUIRechargeAccum);
         this.FUITenTail = new TUITenTail(this);
         this.FUITenTail.Perform_UIDispatch(this.FMC_Context[CONST_FROGWALLET.RESOURCE_LINK_MC_TenTail]);
         this.FUITenTail.OnGetReward = this.ProcessorOnGetReward;
         this.FUITenTail.EffectText = this.ProcessorEffectText;
         this.FUITenTail.TipOnOver = this.ProcessorTipOnOver;
         this.FUITenTail.TipOnOut = this.ProcessorTipOnOut;
         this.FUITenTail.X = INIT_X;
         this.FUITenTail.Y = INIT_Y;
         this.FUITenTail.Visible = false;
         this.FWindowsList.push(this.FUITenTail);
         this.FUIShadow = new TUIShadow(this);
         this.FUIShadow.Perform_UIDispatch(this.FMC_Context[CONST_FROGWALLET.RESOURCE_LINK_MC_Shadow]);
         this.FUIShadow.OnGetReward = this.ProcessorOnGetReward;
         this.FUIShadow.EffectText = this.ProcessorEffectText;
         this.FUIShadow.OnShowPackage = this.ProcessorOnShowPackage;
         this.FUIShadow.OnStartPractice = this.ProcessorOnStartPractice;
         this.FUIShadow.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
         this.FUIShadow.OnShadowGetReward = this.ProcessorOnShadowGetReward;
         this.FUIShadow.X = INIT_X;
         this.FUIShadow.Y = INIT_Y;
         this.FUIShadow.Visible = false;
         this.FWindowsList.push(this.FUIShadow);
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBTN_Goto.addEventListener(MouseEvent.MOUSE_UP,this.ProcessorOnGoto);
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:TBaseActivity = null;
         if(this.visible)
         {
            _loc1_ = SLogicsCore.ActivitiesData.GetActivityByIndex(this.FChangeTabIndex);
            if(!_loc1_)
            {
               return;
            }
            switch(_loc1_.Identify)
            {
               case ACTIVITY_1_ID:
                  this.FTF_Time.text = TGameUtil.fomatTime((_loc1_ as TCornucopia).PayEndTime - STimingCore.GetServerTick());
                  this.FUICornucopia.LogicsPerform();
                  break;
               case ACTIVITY_2_ID:
                  this.FTF_Time.text = TGameUtil.fomatTime((_loc1_ as TRechargeAccum).PayEndTime - STimingCore.GetServerTick());
                  this.FUIRechargeAccum.LogicsPerform();
                  break;
               case ACTIVITY_3_ID:
                  this.FUITenTail.LogicsPerform();
                  break;
               case ACTIVITY_4_ID:
                  this.FUIShadow.LogicsPerform();
            }
         }
         super.LogicsPerform();
      }
      
      protected function UpdateContext() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:TBaseActivity = null;
         _loc3_ = SLogicsCore.ActivitiesData.GetActivityByIndex(this.FChangeTabIndex);
         if(!_loc3_)
         {
            return;
         }
         if(_loc3_.Identify == ACTIVITY_1_ID)
         {
            _loc1_ = uint(STimingCore.GetClientShowTime(_loc3_.BeginTime));
            _loc2_ = uint(STimingCore.GetClientShowTime((_loc3_ as TCornucopia).PayEndTime));
            this.FTF_Date.text = TUtilityString.Format(STRING_FROGWALLET.FormatString_TimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(_loc1_ * 1000)),TUtilityDate.FormatDateChineseNew(new Date((_loc2_ - 1) * 1000)));
         }
         else if(_loc3_.Identify == ACTIVITY_2_ID)
         {
            _loc1_ = uint(STimingCore.GetClientShowTime(_loc3_.BeginTime));
            _loc2_ = uint(STimingCore.GetClientShowTime((_loc3_ as TRechargeAccum).PayEndTime));
            this.FTF_Date.text = TUtilityString.Format(STRING_FROGWALLET.FormatString_TimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(_loc1_ * 1000)),TUtilityDate.FormatDateChineseNew(new Date((_loc2_ - 1) * 1000)));
         }
         this.FTF_Title.text = _loc3_.ActivityName;
         this.FMC_Background.gotoAndStop(_loc3_.Identify);
         this.FTF_Detail.htmlText = _loc3_.ActivityDesc;
      }
      
      protected function UpdateWindow() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TBaseActivity = null;
         _loc2_ = int(this.FWindowsList.length);
         if(this.FChangeTabIndex >= _loc2_)
         {
            return;
         }
         _loc4_ = SLogicsCore.ActivitiesData.GetActivityByIndex(this.FChangeTabIndex);
         switch(_loc4_.Identify)
         {
            case ACTIVITY_1_ID:
               _loc3_ = 0;
               break;
            case ACTIVITY_2_ID:
               _loc3_ = 1;
               break;
            case ACTIVITY_3_ID:
               _loc3_ = 2;
               break;
            case ACTIVITY_4_ID:
               _loc3_ = 3;
         }
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(_loc3_ == _loc1_)
            {
               this.FWindowsList[_loc1_].Visible = true;
               if(this.FWindowsList[_loc1_] is TUICornucopia)
               {
                  (this.FWindowsList[_loc1_] as TUICornucopia).UpdateUI();
               }
               else if(this.FWindowsList[_loc1_] is TUIRechargeAccum)
               {
                  (this.FWindowsList[_loc1_] as TUIRechargeAccum).UpdateUI();
               }
               else if(this.FWindowsList[_loc1_] is TUITenTail)
               {
                  (this.FWindowsList[_loc1_] as TUITenTail).UpdateUI();
               }
               else if(this.FWindowsList[_loc1_] is TUIShadow)
               {
                  (this.FWindowsList[_loc1_] as TUIShadow).UpdateUI();
               }
            }
            else
            {
               this.FWindowsList[_loc1_].Visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function SlotsOnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint = 0) : void
      {
         var _loc5_:TInventory = null;
         var _loc6_:TResourceRepositoryTexture = null;
         var _loc7_:TTexture = null;
         _loc5_ = param2 as TInventory;
         _loc6_ = SResourcesCore.TexturesInventory;
         _loc7_ = _loc6_.GetTextureByIdentifier(_loc5_.IDTexture);
         if(_loc7_ != null)
         {
            param3.Value = _loc7_.GetAnimationSequenceByIdentifier(param4);
         }
         else
         {
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.ACTIVE_Test);
         }
      }
      
      protected function SlotsOnOver(param1:Object, param2:TInventory) : void
      {
         if(this.FOnOverlay != null)
         {
            this.FOnOverlay(this,param2);
         }
      }
      
      protected function SlotsOnOut(param1:Object, param2:TInventory) : void
      {
         if(this.FOnOut != null)
         {
            this.FOnOut(this,param2);
         }
      }
      
      protected function ProcessorTipOnOver(param1:Object, param2:THint) : void
      {
         if(this.FTipOnOver != null)
         {
            this.FTipOnOver(param1,param2);
         }
      }
      
      protected function ProcessorTipOnOut(param1:Object) : void
      {
         if(this.FTipOnOut != null)
         {
            this.FTipOnOut(param1);
         }
      }
      
      protected function ProcessorOnGoto(param1:MouseEvent) : void
      {
         SExternalCore.NavigateToRecharge();
      }
      
      protected function ProcessorOnGetReward(param1:int, param2:int) : void
      {
         if(this.FOnGetReward != null)
         {
            this.FOnGetReward(param1,param2);
         }
      }
      
      protected function ProcessorEffectText(param1:String) : void
      {
         if(this.FEffectText != null)
         {
            this.FEffectText(param1);
         }
      }
      
      protected function ProcessorOnShowPackage() : void
      {
         if(this.FOnShowPackage != null)
         {
            this.FOnShowPackage();
         }
      }
      
      protected function ProcessorOnStartPractice() : void
      {
         if(this.FOnStartPractice != null)
         {
            this.FOnStartPractice();
         }
      }
      
      protected function ProcessorOnShadowGetReward() : void
      {
         if(this.FOnShadowGetReward != null)
         {
            this.FOnShadowGetReward();
         }
      }
      
      public function get OnOverlay() : Function
      {
         return this.FOnOverlay;
      }
      
      public function set OnOverlay(param1:Function) : void
      {
         this.FOnOverlay = param1;
      }
      
      public function get OnOut() : Function
      {
         return this.FOnOut;
      }
      
      public function set OnOut(param1:Function) : void
      {
         this.FOnOut = param1;
      }
      
      public function get TipOnOver() : Function
      {
         return this.FTipOnOver;
      }
      
      public function set TipOnOver(param1:Function) : void
      {
         this.FTipOnOver = param1;
      }
      
      public function get TipOnOut() : Function
      {
         return this.FTipOnOut;
      }
      
      public function set TipOnOut(param1:Function) : void
      {
         this.FTipOnOut = param1;
      }
      
      public function get OnGoto() : Function
      {
         return this.FOnGoto;
      }
      
      public function set OnGoto(param1:Function) : void
      {
         this.FOnGoto = param1;
      }
      
      public function get OnGetReward() : Function
      {
         return this.FOnGetReward;
      }
      
      public function set OnGetReward(param1:Function) : void
      {
         this.FOnGetReward = param1;
      }
      
      public function get EffectText() : Function
      {
         return this.FEffectText;
      }
      
      public function set EffectText(param1:Function) : void
      {
         this.FEffectText = param1;
      }
      
      public function get OnShowPackage() : Function
      {
         return this.FOnShowPackage;
      }
      
      public function set OnShowPackage(param1:Function) : void
      {
         this.FOnShowPackage = param1;
      }
      
      public function get OnStartPractice() : Function
      {
         return this.FOnStartPractice;
      }
      
      public function set OnStartPractice(param1:Function) : void
      {
         this.FOnStartPractice = param1;
      }
      
      public function get OnShadowGetReward() : Function
      {
         return this.FOnShadowGetReward;
      }
      
      public function set OnShadowGetReward(param1:Function) : void
      {
         this.FOnShadowGetReward = param1;
      }
      
      public function Unmount() : void
      {
         this.FUIRechargeAccum.Unmount();
         this.FUICornucopia.Unmount();
      }
      
      public function Perform_UIDispatch(param1:MovieClip) : void
      {
         this.Resources_UIDispatch(param1);
         this.FInitialized = true;
      }
      
      public function ChangeTabOnSwitch(param1:int) : void
      {
         if(param1 == this.FChangeTabIndex)
         {
            return;
         }
         this.visible = true;
         this.FChangeTabIndex = param1;
         this.UpdateUI();
      }
      
      public function UpdateUI() : void
      {
         this.UpdateContext();
         this.UpdateWindow();
      }
      
      public function GetRewardRet(param1:int) : void
      {
         switch(param1)
         {
            case ACTIVITY_1_ID:
               this.FUICornucopia.GetRewardRet();
               break;
            case ACTIVITY_2_ID:
               this.FUIRechargeAccum.GetRewardRet();
               break;
            case ACTIVITY_3_ID:
               this.FUITenTail.GetRewardRet();
               break;
            case ACTIVITY_4_ID:
               this.FUIShadow.GetRewardRet();
         }
      }
      
      public function GetRewardError(param1:int) : void
      {
         switch(param1)
         {
            case ACTIVITY_1_ID:
            case ACTIVITY_2_ID:
               break;
            case ACTIVITY_3_ID:
               this.FUITenTail.BeClicked = false;
               break;
            case ACTIVITY_4_ID:
               this.FUIShadow.UpdateBtn();
         }
      }
      
      public function ProcessorOnItemSelect(param1:Object) : void
      {
         this.FUIShadow.ProcessorOnItemSelect(param1);
      }
      
      public function ProcessorOnPracticeEnd() : void
      {
         var _loc1_:String = null;
         var _loc2_:TShadow = null;
         _loc2_ = SLogicsCore.ActivitiesData.GetActivityByIdentify(ACTIVITY_4_ID) as TShadow;
         switch(_loc2_.Result)
         {
            case RESULT_LOSE:
               _loc1_ = STRING_FROGWALLET.FormatString_LOSE;
               break;
            case RESULT_NOCHANGE:
               _loc1_ = STRING_FROGWALLET.FormatString_NO_Change;
               break;
            case RESULT_LOSE:
               _loc1_ = STRING_FROGWALLET.FormatString_WIN;
         }
         this.ProcessorEffectText(_loc1_);
         this.FUIShadow.ProcessorOnPlayEffect();
         this.FUIShadow.UpdateText();
         this.FUIShadow.UpdateBtn();
         this.FUIShadow.UpdateSlot();
         this.FUIShadow.UpdateRateText();
      }
   }
}

