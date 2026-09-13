package Processors.Game.Lobby.Wing
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TVipConfig;
   import Logics.SLogicsCore;
   import Logics.TransmigrationTrial.TTrialCampaign;
   import Logics.Wing.TWing;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrame;
   import Processors.Game.Lobby.Wing.Component.TUICampaign;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_WING;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TUIWingCampaign extends TUIBaseWindow
   {
      
      protected static const MAX_CAMP_COUNT:uint = 3;
      
      protected var FWing:TWing;
      
      protected var FUICampaignVect:Vector.<TUICampaign>;
      
      protected var FUIWindowConfirmationSure:TUIWindowConfirmation;
      
      protected var FCampaignId:uint;
      
      protected var FMaxResetCount:int;
      
      protected var FResetVip:int;
      
      protected var FResetCampaignID:int;
      
      protected var FResetCost:int;
      
      public function TUIWingCampaign(param1:TUIComponent)
      {
         super(param1);
         this.FWing = SLogicsCore.Character.Wing;
         this.FUICampaignVect = new Vector.<TUICampaign>();
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:TUICampaign = null;
         var _loc6_:Vector.<DisplayObject> = null;
         super.Resources_UIDispatch(param1);
         _loc2_ = 0;
         while(_loc2_ < MAX_CAMP_COUNT)
         {
            _loc5_ = new TUICampaign(FMC_Scene["mc_Campaign" + _loc2_],_loc2_);
            _loc5_.GotoStage = this.ProcessorOnGotoStage;
            _loc5_.ShowConfirmation = this.ShowConfirmation;
            _loc5_.OnAutoBattle = this.ProcessorOnAutoBattle;
            _loc5_.OnAutoTip = this.ProcessorOnAutoTip;
            _loc5_.HideAutoTip = this.ProcessorOnHideAutoTip;
            this.FUICampaignVect.push(_loc5_);
            _loc2_++;
         }
         this.FUIWindowConfirmationSure = new TUIWindowConfirmation(this);
         this.FUIWindowConfirmationSure.OnOK = this.WindowConfirmationSureOnOK;
         this.FUIWindowConfirmationSure.x = (FUICore.StageWidth - this.FUIWindowConfirmationSure.WindowWidth) / 2;
         this.FUIWindowConfirmationSure.y = (FUICore.StageHeight - this.FUIWindowConfirmationSure.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmationSure);
         this.FUIWindowConfirmationSure.visible = false;
         this.FMaxResetCount = (SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_VipConfig,SLogicsCore.Character.VipLevel) as TVipConfig).WingBattleRefresh;
         this.FResetVip = (SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.WING_RESET_VIP) as TConfigValue).Value as int;
      }
      
      protected function UpdateBattle() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUICampaign = null;
         var _loc4_:uint = 0;
         var _loc5_:TTrialCampaign = null;
         _loc1_ = 0;
         while(_loc1_ < MAX_CAMP_COUNT)
         {
            _loc3_ = this.FUICampaignVect[_loc1_];
            _loc5_ = this.FWing.TrialCampaignList[_loc1_];
            _loc3_.SetResetCount(this.FMaxResetCount);
            _loc3_.SetData(_loc5_);
            _loc1_++;
         }
         FMC_Scene.TF_Count0.text = this.FWing.ColorfulFeather.toString();
         FMC_Scene.TF_Count1.text = this.FWing.Stone.toString();
      }
      
      protected function UpdateImage() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TUICampaign = null;
         _loc1_ = 0;
         while(_loc1_ < MAX_CAMP_COUNT)
         {
            _loc2_ = this.FUICampaignVect[_loc1_];
            _loc2_.UpdateImage();
            _loc1_++;
         }
      }
      
      protected function ShowConfirmation(param1:Object, param2:uint, param3:uint, param4:uint) : void
      {
         var _loc5_:String = null;
         if(SLogicsCore.Character.VipLevel >= this.FResetVip && param2 > 0)
         {
            _loc5_ = new ConsumeFrame(STRING_WING.WINGS_STRING_021).DescribeString;
            _loc5_ = TUtilityString.Format(_loc5_,param2,param3);
            this.FResetCampaignID = param4;
            this.FResetCost = param3;
         }
         else if(SLogicsCore.Character.VipLevel < this.FResetVip)
         {
            _loc5_ = new ConsumeFrame(STRING_WING.WINGS_STRING_022).DescribeString;
            _loc5_ = TUtilityString.Format(_loc5_,this.FResetVip);
            this.FResetCampaignID = 0;
            this.FResetCost = 0;
         }
         else
         {
            _loc5_ = new ConsumeFrame(STRING_WING.WINGS_STRING_023).DescribeString;
            this.FResetCampaignID = 0;
            this.FResetCost = 0;
         }
         this.FUIWindowConfirmationSure.Text = _loc5_;
         this.FUIWindowConfirmationSure.Visible = true;
      }
      
      protected function ProcessorOnFreeUp(param1:MouseEvent) : void
      {
         if(FOnGetBox != null && Boolean(this.FWing))
         {
            FOnGetBox(TProcessorWing.COIN_STRENGTHEN);
         }
      }
      
      protected function ProcessorOnGotoStage(param1:TTrialCampaign) : void
      {
         if(FOnGoto != null)
         {
            FOnGoto(TProcessorWing.TAB_STAGE,param1);
         }
      }
      
      protected function ProcessorOnAutoBattle(param1:uint) : void
      {
         if(FOnGetBox != null)
         {
            FOnGetBox(TProcessorWing.AUTO_FIGHT,param1);
         }
      }
      
      protected function WindowConfirmationSureOnOK(param1:Object) : void
      {
         if(this.FResetCampaignID != 0 && FOnBuyBox != null)
         {
            FOnBuyBox(TProcessorWing.RESET,this.FResetCost,this.FResetCampaignID);
         }
      }
      
      protected function ProcessorOnAutoTip(param1:String) : void
      {
         if(OnShowHtmlTip != null)
         {
            OnShowHtmlTip(param1);
         }
      }
      
      protected function ProcessorOnHideAutoTip() : void
      {
         if(OnHideHtmlTip != null)
         {
            OnHideHtmlTip();
         }
      }
      
      override public function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         if(FInitialized && this.visible && FMC_Scene.visible)
         {
            this.UpdateImage();
         }
      }
      
      override public function UpdateUI() : void
      {
         this.UpdateBattle();
      }
      
      override public function Unmount() : void
      {
         this.RoleReset();
      }
      
      public function RoleReset() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TUICampaign = null;
         _loc1_ = 0;
         while(_loc1_ < MAX_CAMP_COUNT)
         {
            _loc2_ = this.FUICampaignVect[_loc1_];
            _loc2_.RoleReset();
            _loc1_++;
         }
      }
   }
}

