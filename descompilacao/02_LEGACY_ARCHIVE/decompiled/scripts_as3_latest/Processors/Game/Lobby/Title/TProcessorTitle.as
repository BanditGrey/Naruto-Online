package Processors.Game.Lobby.Title
{
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Logics.DatebaseVO.VO.TTitleConfig;
   import Logics.SLogicsCore;
   import Logics.Streamization.Title.TUnstreamizerTitle;
   import Logics.Title.TTitle;
   import Logics.Title.TTitles;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyModule;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SHORTCUTS;
   import flash.utils.ByteArray;
   
   public class TProcessorTitle extends TProcessorLobbyModule
   {
      
      protected var FUnstreamizerTitle:TUnstreamizerTitle;
      
      protected var FTitles:TTitles;
      
      protected var FOnUpdateTitleInfo:Function;
      
      protected var FOnUpdateLittlePetInfo:Function;
      
      protected var FOnEffectNewMail:Function;
      
      public function TProcessorTitle(param1:TUIComponent, param2:TLobbyParameters = null)
      {
         super(param1,param2);
         this.FUnstreamizerTitle = new TUnstreamizerTitle();
         this.FTitles = SLogicsCore.Titles;
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Title_LoadTitleList_Ret,this.PerformPacket_SC_LoadTitleList_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Title_AddTitle_Ret,this.PerformPacket_SC_AddTitle_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Title_EquipTitle_Ret,this.PerformPacket_SC_EquipTitle_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Title_DelTitle_Ret,this.PerformPacket_SC_DelTitle_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Title_ActivityPetLoad_Ret,this.PerformPacket_SC_ActivityPetLoad_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Title_ActivityPetRemove_Ret,this.PerformPacket_SC_ActivityPetRemove_Ret);
         super.PacketRegisterRoutines();
      }
      
      protected function PerformPacket_SC_LoadTitleList_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc4_ = _loc2_.readUnsignedInt();
         this.FUnstreamizerTitle.Unstreamize(_loc2_,this.FTitles,null);
         this.FTitles.SetEquipTitle(_loc4_);
         if(this.FOnUpdateTitleInfo != null)
         {
            this.FOnUpdateTitleInfo(this,_loc4_);
         }
      }
      
      protected function PerformPacket_SC_AddTitle_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:TTitleConfig = null;
         var _loc7_:TTitle = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc4_ = _loc2_.readUnsignedInt();
         _loc5_ = _loc2_.readUnsignedInt();
         _loc7_ = this.FTitles.GetTitleByIdentifier(_loc4_);
         if(_loc7_ != null)
         {
            _loc7_.EndTime = _loc5_;
            return;
         }
         _loc6_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_TitleConfig,_loc4_) as TTitleConfig;
         _loc7_ = new TTitle();
         _loc7_.Identifier = _loc4_;
         _loc7_.TitleName = _loc6_.Title;
         _loc7_.TitleSource = _loc6_.TitleDesc;
         _loc7_.VipLevel = _loc6_.VipLv;
         _loc7_.Level = _loc6_.UsrLv;
         _loc7_.ImageId = _loc6_.ImageId;
         _loc7_.AddValues = _loc6_.AddValues;
         _loc7_.EndTime = _loc5_;
         this.FTitles.Add(_loc7_);
         this.FTitles.HasNewTitle = true;
         if(this.FOnEffectNewMail != null)
         {
            this.FOnEffectNewMail(CONST_SHORTCUTS.POSITION_Function,CONST_SHORTCUTS.TYPE_Function_Heros,true);
         }
      }
      
      protected function PerformPacket_SC_EquipTitle_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc4_ = _loc2_.readUnsignedInt();
         this.FTitles.SetEquipTitle(_loc4_);
         if(this.FOnUpdateTitleInfo != null)
         {
            this.FOnUpdateTitleInfo(this,_loc4_);
         }
      }
      
      protected function PerformPacket_SC_DelTitle_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         _loc2_ = param1.Data;
         _loc4_ = _loc2_.readUnsignedInt();
         this.FTitles.DeleteTitleByIdentifier(_loc4_);
         if(this.FOnUpdateTitleInfo != null)
         {
            this.FOnUpdateTitleInfo(this,0);
         }
      }
      
      protected function PerformPacket_SC_ActivityPetLoad_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc4_ = _loc2_.readUnsignedInt();
         if(this.FOnUpdateLittlePetInfo != null)
         {
            this.FOnUpdateLittlePetInfo(_loc4_);
         }
      }
      
      protected function PerformPacket_SC_ActivityPetRemove_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            _loc3_ = 0;
         }
         if(this.FOnUpdateLittlePetInfo != null)
         {
            this.FOnUpdateLittlePetInfo(this,_loc3_);
         }
      }
      
      public function get OnUpdateTitleInfo() : Function
      {
         return this.FOnUpdateTitleInfo;
      }
      
      public function set OnUpdateTitleInfo(param1:Function) : void
      {
         this.FOnUpdateTitleInfo = param1;
      }
      
      public function get OnUpdateLittlePetInfo() : Function
      {
         return this.FOnUpdateLittlePetInfo;
      }
      
      public function set OnUpdateLittlePetInfo(param1:Function) : void
      {
         this.FOnUpdateLittlePetInfo = param1;
      }
      
      public function get OnEffectNewMail() : Function
      {
         return this.FOnEffectNewMail;
      }
      
      public function set OnEffectNewMail(param1:Function) : void
      {
         this.FOnEffectNewMail = param1;
      }
   }
}

