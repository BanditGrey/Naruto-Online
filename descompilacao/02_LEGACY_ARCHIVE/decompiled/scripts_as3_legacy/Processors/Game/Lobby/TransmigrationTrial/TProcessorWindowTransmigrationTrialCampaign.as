package Processors.Game.Lobby.TransmigrationTrial
{
   import Components.ComboBox.TComboBox;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.SLogicsCore;
   import Logics.TransmigrationTrial.TTransmigrationTrialData;
   import Logics.TransmigrationTrial.TTrialCampaign;
   import Processors.Game.Lobby.TransmigrationTrial.Component.TUICampaign;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrame;
   import Processors.Game.TProcessorGame;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Constants.CONST_TRANSMIGRATIONTRIAL;
   import Resources.Strings.STRING_TRANSMIGRATIONTRIAL;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TProcessorWindowTransmigrationTrialCampaign extends TProcessorGame
   {
      
      protected static const MAX_CAMP_COUNT:uint = 3;
      
      protected var FScene:MovieClip;
      
      protected var FReincarnatonComboBox:TComboBox;
      
      protected var FUICampaignVect:Vector.<TUICampaign>;
      
      protected var FTransmigrationTrialData:TTransmigrationTrialData;
      
      protected var FReincarnatonIndex:uint;
      
      protected var FCampaignId:uint;
      
      protected var FUIWindowConfirmationSure:TUIWindowConfirmation;
      
      protected var FGotoStage:Function;
      
      protected var FShowChangeView:Function;
      
      public function TProcessorWindowTransmigrationTrialCampaign(param1:TUIComponent)
      {
         super(param1);
         this.FReincarnatonIndex = 0;
         this.FUICampaignVect = new Vector.<TUICampaign>();
         this.FTransmigrationTrialData = SLogicsCore.TransmigrationTrialData;
      }
      
      protected function OnTransmigrationLevelSelect(param1:Object, param2:uint) : void
      {
         this.FReincarnatonIndex = param2;
         this.Update();
      }
      
      protected function MakeComboItem(param1:String) : DisplayObject
      {
         var _loc2_:MovieClip = null;
         _loc2_ = TUtilityReflection.CreateDisplayObjectInstance(CONST_TRANSMIGRATIONTRIAL.RESOURCE_ClassName_TransmigrationEquit_BoxItem) as MovieClip;
         _loc2_.tf_into.text = param1;
         return _loc2_;
      }
      
      protected function OnGotoStage(param1:Object, param2:TTrialCampaign) : void
      {
         if(this.FGotoStage != null)
         {
            this.FGotoStage(param1,param2);
         }
      }
      
      protected function ShowConfirmation(param1:Object, param2:uint, param3:uint, param4:uint) : void
      {
         var _loc5_:String = null;
         this.FCampaignId = param4;
         if(SLogicsCore.KaguyaData.OpenState == 0)
         {
            _loc5_ = STRING_TRANSMIGRATIONTRIAL.STRING_Kaguya_0;
         }
         else if(SLogicsCore.KaguyaData.OpenState != 0 && SLogicsCore.KaguyaData.IsLongTime == 7)
         {
            _loc5_ = STRING_TRANSMIGRATIONTRIAL.STRING_Kaguya_1;
         }
         else
         {
            _loc5_ = TUtilityString.Format(STRING_TRANSMIGRATIONTRIAL.STRING_Kaguya_2,SLogicsCore.KaguyaData.CurLevel,param2);
         }
         if(int((this.FCampaignId - 1) % 10000 / 3) == 0)
         {
            _loc5_ += new ConsumeFrame(CONST_SYSTEMLANGUAGE.ConsumerConfirm_TransmigrationTrialResetCost0).DescribeString;
         }
         else
         {
            _loc5_ += new ConsumeFrame(CONST_SYSTEMLANGUAGE.ConsumerConfirm_TransmigrationTrialResetCost1).DescribeString;
         }
         this.FUIWindowConfirmationSure.Text = TUtilityString.Format(_loc5_,param3);
         this.FUIWindowConfirmationSure.Visible = true;
      }
      
      protected function WindowConfirmationSureOnOK(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TransmigrationTrial_ResetCampaign_Req);
         _loc2_.Data.writeUnsignedInt(this.FCampaignId);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function UpdateResetCount() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TUICampaign = null;
         _loc1_ = 0;
         while(_loc1_ < MAX_CAMP_COUNT)
         {
            _loc2_ = this.FUICampaignVect[_loc1_];
            _loc2_.SetResetCount(SLogicsCore.KaguyaData.GetMaxValueByType(9));
            _loc1_++;
         }
      }
      
      protected function OnChangeClick(param1:MouseEvent) : void
      {
         if(this.FShowChangeView != null)
         {
            this.FShowChangeView(this);
         }
      }
      
      public function get GotoStage() : Function
      {
         return this.FGotoStage;
      }
      
      public function set GotoStage(param1:Function) : void
      {
         this.FGotoStage = param1;
      }
      
      public function get ShowChangeView() : Function
      {
         return this.FShowChangeView;
      }
      
      public function set ShowChangeView(param1:Function) : void
      {
         this.FShowChangeView = param1;
      }
      
      public function SetScene(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TUICampaign = null;
         var _loc5_:Vector.<DisplayObject> = null;
         var _loc6_:DisplayObject = null;
         this.FScene = param1;
         addChild(this.FScene);
         _loc2_ = 0;
         while(_loc2_ < MAX_CAMP_COUNT)
         {
            _loc4_ = new TUICampaign(this.FScene["mc_Campaign" + _loc2_],_loc2_);
            _loc4_.GotoStage = this.OnGotoStage;
            _loc4_.ShowConfirmation = this.ShowConfirmation;
            this.FUICampaignVect.push(_loc4_);
            _loc2_++;
         }
         _loc5_ = new Vector.<DisplayObject>();
         _loc3_ = STRING_TRANSMIGRATIONTRIAL.STRING_ReincarnatonLevel.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc6_ = this.MakeComboItem(STRING_TRANSMIGRATIONTRIAL.STRING_ReincarnatonLevel[_loc2_]);
            _loc5_.push(_loc6_);
            _loc2_++;
         }
         this.FReincarnatonComboBox = new TComboBox(this,this.FScene["mc_list_transmigration"],_loc5_,79,this.OnTransmigrationLevelSelect);
         TGameUtil.setButtonMode(this.FScene["btn_Change"],true);
         this.FScene["btn_Change"].addEventListener(MouseEvent.CLICK,this.OnChangeClick);
         this.FUIWindowConfirmationSure = new TUIWindowConfirmation(this);
         this.FUIWindowConfirmationSure.OnOK = this.WindowConfirmationSureOnOK;
         this.FUIWindowConfirmationSure.x = (FUICore.StageWidth - this.FUIWindowConfirmationSure.WindowWidth) / 2;
         this.FUIWindowConfirmationSure.y = (FUICore.StageHeight - this.FUIWindowConfirmationSure.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmationSure);
         this.FUIWindowConfirmationSure.visible = false;
      }
      
      public function Update() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUICampaign = null;
         var _loc4_:uint = 0;
         var _loc5_:TTrialCampaign = null;
         _loc4_ = CONST_TRANSMIGRATIONTRIAL.CONST_CampaignStartId + (this.FReincarnatonIndex == 0 ? 0 : 3 * this.FReincarnatonIndex);
         _loc1_ = 0;
         while(_loc1_ < MAX_CAMP_COUNT)
         {
            _loc3_ = this.FUICampaignVect[_loc1_];
            _loc5_ = this.FTransmigrationTrialData.GetTrialCampaignByCampaignId(_loc4_ + _loc1_);
            if(_loc5_ == null)
            {
               _loc5_ = new TTrialCampaign();
               _loc5_.CampaignId = _loc4_ + _loc1_;
               this.FTransmigrationTrialData.AddTrialCampaign(_loc5_);
            }
            _loc3_.SetData(_loc5_);
            _loc1_++;
         }
         this.UpdateResetCount();
      }
      
      public function UpdateImage() : void
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

