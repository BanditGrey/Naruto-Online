package Processors.Game.Lobby.TransmigrationAccessory
{
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityString;
   import Logics.SLogicsCore;
   import Logics.TransmigrationAccessory.TAccessoryCampaign;
   import Logics.TransmigrationAccessory.TTransmigrationAccessoryData;
   import Processors.Game.Lobby.TransmigrationAccessory.Component.TUICampaign;
   import Processors.Game.TProcessorGame;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_TRANSMIGRATIONACCESSORY;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   
   public class TProcessorWindowTransmigrationAccessoryCampaign extends TProcessorGame
   {
      
      protected static const MAX_CAMP_COUNT:uint = 3;
      
      protected var FScene:MovieClip;
      
      protected var FUICampaignVect:Vector.<TUICampaign>;
      
      protected var FTransmigrationAccessoryData:TTransmigrationAccessoryData;
      
      protected var FCampaignId:uint;
      
      protected var FUIWindowConfirmationSure:TUIWindowConfirmation;
      
      protected var FGotoStage:Function;
      
      public function TProcessorWindowTransmigrationAccessoryCampaign(param1:TUIComponent)
      {
         super(param1);
         this.FUICampaignVect = new Vector.<TUICampaign>();
         this.FTransmigrationAccessoryData = SLogicsCore.TransmigrationAccessoryData;
      }
      
      protected function OnGotoStage(param1:Object, param2:TAccessoryCampaign) : void
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
         if(!this.FUIWindowConfirmationSure.IsSelected && param3 > 0)
         {
            this.FUIWindowConfirmationSure.Text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_ConfirmGold,param3);
            this.FUIWindowConfirmationSure.SetCheckBox(true);
            this.FUIWindowConfirmationSure.Visible = true;
         }
         else
         {
            this.WindowConfirmationSureOnOK(this);
         }
      }
      
      protected function WindowConfirmationSureOnOK(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TransmigrationAccessory_ResetCampaign_Req);
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
            _loc2_.SetResetCount(SLogicsCore.KaguyaData.GetMaxValueByType(13));
            _loc1_++;
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
      
      public function SetScene(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TUICampaign = null;
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
         var _loc5_:TAccessoryCampaign = null;
         _loc4_ = CONST_TRANSMIGRATIONACCESSORY.CONST_CampaignStartId;
         _loc1_ = 0;
         while(_loc1_ < MAX_CAMP_COUNT)
         {
            _loc3_ = this.FUICampaignVect[_loc1_];
            _loc5_ = this.FTransmigrationAccessoryData.GetAccessoryCampaignByCampaignId(_loc4_ + _loc1_);
            if(_loc5_ == null)
            {
               _loc5_ = new TAccessoryCampaign();
               _loc5_.CampaignId = _loc4_ + _loc1_;
               this.FTransmigrationAccessoryData.AddAccessoryCampaign(_loc5_);
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
   }
}

