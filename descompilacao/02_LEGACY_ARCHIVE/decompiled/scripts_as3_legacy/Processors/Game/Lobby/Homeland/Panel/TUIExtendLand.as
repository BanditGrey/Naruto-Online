package Processors.Game.Lobby.Homeland.Panel
{
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Utilities.TGameUtil;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TMarryClass;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Homeland.THomelandModel;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Strings.STRING_COMMON;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.events.MouseEvent;
   
   public class TUIExtendLand
   {
      
      protected var FMC_Scene:MovieClip;
      
      protected var FMask:Shape = null;
      
      public function TUIExtendLand(param1:MovieClip)
      {
         super();
         this.FMC_Scene = param1;
         this.FMC_Scene.parent.setChildIndex(this.FMC_Scene,this.FMC_Scene.parent.numChildren - 1);
         this.FMC_Scene.BTN_Close.addEventListener(MouseEvent.CLICK,this.OnClose);
         this.FMask = new Shape();
         this.FMask.graphics.beginFill(0,0.8);
         this.FMask.graphics.drawRect(-this.FMC_Scene.x,-this.FMC_Scene.y,1250,650);
         this.FMask.graphics.endFill();
         this.FMC_Scene.addChildAt(this.FMask,0);
      }
      
      public function UpdateUI() : void
      {
         var _loc6_:Object = null;
         var _loc7_:TMarryClass = null;
         var _loc8_:MovieClip = null;
         var _loc1_:int = THomelandModel.getExtendLand();
         var _loc2_:TMarryClass = THomelandModel.getMarryVOByExp(THomelandModel.selfHome.charm);
         var _loc3_:TBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_ConfigValue);
         var _loc4_:TConfigValue = _loc3_.GetDatebaseByIdentifier(91100019) as TConfigValue;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_.Value.length)
         {
            _loc6_ = _loc4_.Value[_loc5_];
            _loc7_ = THomelandModel.MarryClass.GetDatebaseByIdentifier(_loc6_.lv) as TMarryClass;
            _loc8_ = this.FMC_Scene["MC_ExtendLand_" + _loc5_];
            _loc8_.TF_Number.text = _loc5_ + 1 + "块";
            _loc8_.TF_Marry.text = _loc7_.Name + " (Lv." + _loc7_.Stars + ")";
            _loc8_.TF_Charge.text = _loc6_.consume + STRING_COMMON.ITEMNAME_Gold;
            if(_loc5_ < _loc1_)
            {
               this.FMC_Scene.gotoAndStop(3);
               _loc8_.MC_Open.visible = false;
               _loc8_.MC_Opened.visible = true;
               _loc8_.TF_Marry.textColor = 16777215;
               _loc8_.TF_Charge.textColor = 16777215;
            }
            else
            {
               _loc8_.MC_Open.visible = true;
               _loc8_.MC_Opened.visible = false;
               _loc8_.TF_Marry.textColor = _loc2_.Identifier >= _loc6_.lv ? 65297 : 16711697;
               _loc8_.TF_Charge.textColor = SLogicsCore.Character.CreditGold >= _loc6_.consume ? 65297 : 16711697;
               if(_loc2_.Identifier < _loc6_.lv || SLogicsCore.Character.CreditGold < _loc6_.consume || _loc5_ != _loc1_)
               {
                  this.FMC_Scene.gotoAndStop(1);
                  TGameUtil.setButtonMode(_loc8_.MC_Open,false);
               }
               else
               {
                  this.FMC_Scene.gotoAndStop(2);
                  TGameUtil.setButtonMode(_loc8_.MC_Open,true);
                  _loc8_.MC_Open.addEventListener(MouseEvent.CLICK,this.onOpenClick);
               }
            }
            _loc5_++;
         }
      }
      
      private function OnClose(param1:MouseEvent) : void
      {
         this.visible = false;
      }
      
      private function onOpenClick(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         if(THomelandModel.Status == 0)
         {
            _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Married_BuyLandReq);
            SNetworkCore.Transceiver.PacketTransmit(_loc2_);
            this.visible = false;
         }
      }
      
      public function get visible() : Boolean
      {
         return this.FMC_Scene.visible;
      }
      
      public function set visible(param1:Boolean) : void
      {
         this.FMC_Scene.visible = param1;
         if(this.FMC_Scene.visible)
         {
            this.UpdateUI();
         }
      }
   }
}

