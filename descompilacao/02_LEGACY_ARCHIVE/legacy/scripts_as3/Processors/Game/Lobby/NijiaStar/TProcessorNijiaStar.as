package Processors.Game.Lobby.NijiaStar
{
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Logics.Characters.THero;
   import Logics.Characters.THeros;
   import Logics.DatebaseVO.VO.TSevenHeroSoul;
   import Logics.NijiaStar.TNijiaStar;
   import Logics.NijiaStar.TNijiaStarAtom;
   import Logics.SLogicsCore;
   import Logics.Streamization.Nijiastar.TUnstreamizerNijiaStar;
   import Processors.Game.Common.Effects.Texts.TEffectCoordinateParameters;
   import Processors.Game.Common.Effects.Texts.TEffectTextParameters;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyPlate;
   import Processors.Game.Lobby.NijiaStar.Components.TUIMainPoint;
   import Rendering.Overlayers.HelpTips.TOverlayerHelpTips;
   import Rendering.Overlayers.Hints.TOverlayerHint;
   import Rendering.Overlayers.NijiaStar.TOverLayerKingSoul;
   import Rendering.Overlayers.NijiaStar.TOverlayerNijiaStarAttribute;
   import Rendering.Overlayers.NijiaStar.TOverlayerNijiaStarMainPoint;
   import Rendering.Overlayers.NijiaStar.TOverlayerNijiaStarSubPoint;
   import Rendering.Overlayers.TOverlayer;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_NIJIASTAR;
   import Resources.Strings.STRING_NIJIASTAR;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.utils.ByteArray;
   
   public class TProcessorNijiaStar extends TProcessorLobbyPlate
   {
      
      protected const CAPACITY_NijiaStar:uint = 10;
      
      protected const CAPACITY_KingSouls:uint = 8;
      
      protected var FProcessorWindowNijiaStar:TProcessorWindowNijiaStar;
      
      protected var FProcessorWindowMainPoint:TProcessorWindowMainPoint;
      
      protected var FProcessorWindowNijiaStarExchange:TProcessorWindowNijiaStarExchange;
      
      protected var FUnstreamizerNijiaStar:TUnstreamizerNijiaStar;
      
      protected var FHero:THero;
      
      protected var FOverlayerNijiaStarMainPoint:TOverlayerNijiaStarMainPoint;
      
      protected var FOverlayerNijiaStarSubPoint:TOverlayerNijiaStarSubPoint;
      
      protected var FOverlayerNijiaStarAttribute:TOverlayerNijiaStarAttribute;
      
      protected var FOverLayerKingSoul:TOverLayerKingSoul;
      
      protected var FOverlayerHint:TOverlayerHint;
      
      protected var FOverlayerHelpTips:TOverlayerHelpTips;
      
      protected var FNijiaStar:TNijiaStar;
      
      protected var FIndex:int;
      
      protected var FIsNeedRequest:Boolean;
      
      protected var FIsInit:Boolean;
      
      protected var FOnReturnMainScene:Function;
      
      protected var FGetKingSoulOnClick:Function;
      
      protected var FOnUpdateHerosBaseAttributeReq:Function;
      
      protected var FOnUserTotalFightingPowerReq:Function;
      
      public function TProcessorNijiaStar(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FProcessorWindowNijiaStar = new TProcessorWindowNijiaStar(this);
         this.FProcessorWindowNijiaStar.OnClose = this.ProcessorOnClose;
         this.FProcessorWindowNijiaStar.MainPointOnClick = this.ProcessorOnMainPointOnClick;
         this.FProcessorWindowNijiaStar.ExchangeOnClick = this.ProcessorOnOpenWindowExchange;
         this.FProcessorWindowNijiaStar.GetKingSoulOnClick = this.ProcessorGetKingSoulOnClick;
         this.FProcessorWindowNijiaStar.UIComponentsOnOver = this.UIComponentsOverlayerOnOver;
         this.FProcessorWindowNijiaStar.UIComponentsOnOut = this.UIComponentsOverlayerOnOut;
         this.FProcessorWindowNijiaStar.UIHintOnOut = this.UIHintOnOut;
         this.FProcessorWindowNijiaStar.UIHintOnOver = this.UIHintOnOver;
         this.FProcessorWindowNijiaStar.OnHelpTipsOver = this.UIHelpTipsHintOnOver;
         this.FProcessorWindowNijiaStar.OnHelpTipsOut = this.UIHelpTipsHintOnOut;
         this.FProcessorWindowMainPoint = new TProcessorWindowMainPoint(this);
         this.FProcessorWindowMainPoint.OnClose = this.ProcessorWindowMainPointOnClose;
         this.FProcessorWindowMainPoint.OnClick = this.ProcessorSubPointOnClick;
         this.FProcessorWindowMainPoint.OnNijiaPointOver = this.UIComponentsOverlayerOnOver;
         this.FProcessorWindowMainPoint.OnNijiaPointOut = this.UIComponentsOverlayerOnOut;
         this.FProcessorWindowNijiaStarExchange = new TProcessorWindowNijiaStarExchange(this);
         this.FProcessorWindowNijiaStarExchange.OnClose = this.ProcessorOnWindowExchangeClose;
         this.FProcessorWindowNijiaStarExchange.ExchangeOnClick = this.ProcessorOnExchange;
         this.FProcessorWindowNijiaStarExchange.UIComponentsOnOut = this.UIComponentsOverlayerOnOut;
         this.FProcessorWindowNijiaStarExchange.UIComponentsOnOver = this.UIComponentsOverlayerOnOver;
         this.FProcessorWindowNijiaStarExchange.OnEffectText = this.ProdessorOnEffectText;
         this.FOverlayerNijiaStarMainPoint = new TOverlayerNijiaStarMainPoint(this);
         this.FOverlayerNijiaStarMainPoint.Visible = false;
         this.FOverlayerNijiaStarSubPoint = new TOverlayerNijiaStarSubPoint(this);
         this.FOverlayerNijiaStarSubPoint.Visible = false;
         this.FOverlayerNijiaStarAttribute = new TOverlayerNijiaStarAttribute(this,CONST_MODULES.MODULE_NijiaStar);
         this.FOverlayerNijiaStarAttribute.Visible = false;
         this.FOverLayerKingSoul = new TOverLayerKingSoul(this);
         this.FOverLayerKingSoul.Visible = false;
         this.FOverlayerHint = new TOverlayerHint(this);
         this.FOverlayerHint.Visible = false;
         this.FOverlayerHelpTips = new TOverlayerHelpTips(this);
         this.FOverlayerHelpTips.visible = false;
         this.FUnstreamizerNijiaStar = new TUnstreamizerNijiaStar();
         this.FIsNeedRequest = false;
         this.FIsInit = false;
         SetUIModuleID(CONST_MODULES.MODULE_NijiaStar);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_NIJIASTAR.RESOURCESID_Swf_NjiaStar);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerNijiaStarMainPoint);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerNijiaStarSubPoint);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerNijiaStarAttribute);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverLayerKingSoul);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerHint);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerHelpTips);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NijiaStar_NijiaStarUpdate,this.PacketPerform_SC_NijiaStarUpdate);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NijiaStar_NijiaSoulUpdate,this.PacketPerform_SC_NijiaSoulUpdate);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NijiaStar_LevelUpRet,this.PacketPerform_SC_LevelUpRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NijiaStar_ExchangeRet,this.PacketPerform_SC_ExchangeRet);
         super.PacketRegisterRoutines();
      }
      
      protected function PacketPerform_SC_NijiaStarUpdate(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:ByteArray = null;
         var _loc7_:uint = 0;
         var _loc8_:THeros = null;
         var _loc9_:THero = null;
         var _loc10_:uint = 0;
         var _loc11_:TNijiaStar = null;
         _loc6_ = param1.Data;
         _loc4_ = uint(_loc6_.readShort());
         _loc8_ = SLogicsCore.Character.Heros;
         _loc8_.Sort();
         _loc2_ = 0;
         while(_loc2_ < _loc4_)
         {
            _loc10_ = _loc6_.readUnsignedInt();
            _loc9_ = _loc8_.GetHeroByIdentifier(_loc10_);
            if(_loc9_ == null)
            {
               this.FIsNeedRequest = true;
               break;
            }
            _loc5_ = this.CAPACITY_NijiaStar;
            _loc3_ = 0;
            while(_loc3_ < _loc5_)
            {
               this.FUnstreamizerNijiaStar.Unstreamize(_loc6_,_loc9_.NijiaStars,_loc3_);
               _loc3_++;
            }
            _loc2_++;
         }
         if(FIsResourcesLoadCompleted)
         {
            if(this.FIsNeedRequest)
            {
               this.FProcessorWindowNijiaStar.UpdateUI();
            }
            else
            {
               this.FProcessorWindowNijiaStar.UpdateUIMainPoint();
            }
         }
         this.FIsInit = true;
      }
      
      protected function PacketPerform_SC_NijiaSoulUpdate(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:ByteArray = null;
         var _loc5_:uint = 0;
         _loc4_ = param1.Data;
         _loc3_ = this.CAPACITY_KingSouls;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc5_ = _loc4_.readUnsignedInt();
            SLogicsCore.Character.SetKingSoulByIndex(_loc2_,_loc5_);
            _loc2_++;
         }
         if(this.Visible)
         {
            this.FProcessorWindowNijiaStar.UpdateSoulCount();
         }
      }
      
      protected function PacketPerform_SC_LevelUpRet(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:ByteArray = null;
         var _loc5_:uint = 0;
         _loc4_ = param1.Data;
         _loc5_ = _loc4_.readUnsignedInt();
         if(_loc5_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc5_);
            return;
         }
         EffectGenerateText(STRING_NIJIASTAR.STRING_LelvelUp);
         this.UIComponentsOverlayerOnOut(this.FProcessorWindowMainPoint,null);
         this.FProcessorWindowMainPoint.UpdateUI(this.FNijiaStar);
         this.FProcessorWindowNijiaStar.UpdateUIMainPoint();
         if(this.FOnUpdateHerosBaseAttributeReq != null)
         {
            this.FOnUpdateHerosBaseAttributeReq(this);
         }
         if(this.FOnUserTotalFightingPowerReq != null)
         {
            this.FOnUserTotalFightingPowerReq(this);
         }
      }
      
      protected function PacketPerform_SC_ExchangeRet(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:ByteArray = null;
         var _loc5_:uint = 0;
         _loc4_ = param1.Data;
         _loc5_ = _loc4_.readUnsignedInt();
         if(_loc5_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc5_);
            return;
         }
         if(FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowNijiaStarExchange.Update();
         }
         if(this.FProcessorWindowNijiaStarExchange.Visible)
         {
            EffectGenerateText(STRING_NIJIASTAR.STRING_Exchange);
         }
         if(this.FOnUpdateHerosBaseAttributeReq != null)
         {
            this.FOnUpdateHerosBaseAttributeReq(this);
         }
         if(this.FOnUserTotalFightingPowerReq != null)
         {
            this.FOnUserTotalFightingPowerReq(this);
         }
      }
      
      protected function PacketPerform_C2S_StarUpdateReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_NijiaStar_NijiaStarUpdateReq);
         _loc2_ = _loc1_.Data;
         _loc2_.writeUnsignedInt(0);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PacketPerform_CS_NijiaSoulUpdateReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_NijiaStar_NijiaSoulUpdateReq);
         _loc2_ = _loc1_.Data;
         _loc2_.writeUnsignedInt(0);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function ProdessorOnEffectText(param1:Object, param2:String, param3:TEffectTextParameters = null, param4:TEffectCoordinateParameters = null) : void
      {
         if(FOnEffectText != null)
         {
            FOnEffectText(this,param2);
         }
      }
      
      protected function UIComponentsOverlayerOnOver(param1:Object, param2:Object, param3:Object = null) : void
      {
         var _loc4_:TOverlayer = null;
         var _loc5_:TNijiaStar = null;
         var _loc6_:TNijiaStarAtom = null;
         var _loc7_:THero = null;
         var _loc8_:TSevenHeroSoul = null;
         if(param1 is TProcessorWindowMainPoint)
         {
            _loc4_ = this.FOverlayerNijiaStarSubPoint;
            if(param2 is TNijiaStar)
            {
               _loc5_ = param2 as TNijiaStar;
               _loc4_.Context = _loc5_;
            }
            else if(param2 is TNijiaStarAtom)
            {
               _loc6_ = param2 as TNijiaStarAtom;
               _loc4_.Context = _loc6_;
               this.FOverlayerNijiaStarSubPoint.SubContext = param3;
            }
         }
         else if(param1 is TProcessorWindowNijiaStar)
         {
            if(param2 is TNijiaStar)
            {
               _loc5_ = param2 as TNijiaStar;
               _loc4_ = this.FOverlayerNijiaStarMainPoint;
               _loc4_.Context = _loc5_;
            }
            else if(param2 is THero)
            {
               _loc7_ = param2 as THero;
               _loc4_ = this.FOverlayerNijiaStarAttribute;
               _loc4_.Context = _loc7_;
            }
            else if(param2 is TSevenHeroSoul)
            {
               _loc8_ = param2 as TSevenHeroSoul;
               _loc4_ = this.FOverLayerKingSoul;
               _loc4_.Context = _loc8_;
            }
         }
         else if(param1 is TProcessorWindowNijiaStarExchange)
         {
            _loc7_ = param2 as THero;
            _loc4_ = this.FOverlayerNijiaStarAttribute;
            _loc4_.Context = _loc7_;
         }
         if(_loc4_ != null)
         {
            _loc4_.Render(FUICore.MouseCoordinate);
            _loc4_.CoordinateOverlay.X -= _loc4_.BoundsSubstrate.Width + 20;
            _loc4_.Show();
         }
      }
      
      protected function UIComponentsOverlayerOnOut(param1:Object, param2:Object) : void
      {
         var _loc3_:TOverlayer = null;
         if(param1 is TProcessorWindowMainPoint)
         {
            _loc3_ = this.FOverlayerNijiaStarSubPoint;
         }
         else if(param1 is TProcessorWindowNijiaStar)
         {
            if(param2 is TNijiaStar)
            {
               _loc3_ = this.FOverlayerNijiaStarMainPoint;
            }
            else if(param2 is THero)
            {
               _loc3_ = this.FOverlayerNijiaStarAttribute;
            }
            else if(param2 is TSevenHeroSoul)
            {
               _loc3_ = this.FOverLayerKingSoul;
            }
         }
         else if(param1 is TProcessorWindowNijiaStarExchange)
         {
            _loc3_ = this.FOverlayerNijiaStarAttribute;
         }
         if(_loc3_ != null)
         {
            _loc3_.Hide();
         }
      }
      
      protected function UIHintOnOver(param1:Object, param2:THint) : void
      {
         this.FOverlayerHint.Context = param2;
         this.FOverlayerHint.Render(FUICore.MouseCoordinate);
         this.FOverlayerHint.visible = true;
      }
      
      protected function UIHintOnOut(param1:Object) : void
      {
         this.FOverlayerHint.visible = false;
      }
      
      protected function ProcessorOnClose(param1:Object) : void
      {
         if(this.FOnReturnMainScene != null)
         {
            this.FOnReturnMainScene(this);
         }
      }
      
      protected function ProcessorWindowMainPointOnClose(param1:Object) : void
      {
         this.FProcessorWindowMainPoint.Visible = false;
      }
      
      protected function ProcessorOnWindowExchangeClose(param1:Object) : void
      {
         this.FProcessorWindowNijiaStarExchange.Visible = false;
      }
      
      protected function ProcessorOnMainPointOnClick(param1:Object, param2:Object, param3:TUIMainPoint, param4:THero) : void
      {
         this.FProcessorWindowMainPoint.Visible = true;
         this.FProcessorWindowMainPoint.UpdateSubPoint(param2,param3);
         this.FHero = param4;
         this.FIndex = param3.Tag;
         this.FNijiaStar = param2 as TNijiaStar;
      }
      
      protected function ProcessorOnOpenWindowExchange(param1:Object) : void
      {
         this.FProcessorWindowNijiaStarExchange.Visible = true;
         this.FProcessorWindowNijiaStarExchange.Update();
      }
      
      protected function ProcessorGetKingSoulOnClick(param1:Object) : void
      {
         if(this.FGetKingSoulOnClick != null)
         {
            this.FGetKingSoulOnClick(this);
         }
      }
      
      protected function ProcessorOnExchange(param1:Object, param2:Object, param3:Object) : void
      {
         var _loc4_:TPacket = null;
         var _loc5_:ByteArray = null;
         if(param2 == null || param3 == null)
         {
            return;
         }
         _loc4_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_NijiaStar_ExchangeReq);
         _loc5_ = _loc4_.Data;
         _loc5_.writeUnsignedInt((param2 as THero).Identifier);
         _loc5_.writeUnsignedInt((param3 as THero).Identifier);
         SNetworkCore.Transceiver.PacketTransmit(_loc4_);
      }
      
      protected function ProcessorSubPointOnClick(param1:Object, param2:Object) : void
      {
         var _loc3_:TNijiaStarAtom = null;
         var _loc4_:TPacket = null;
         var _loc5_:ByteArray = null;
         var _loc6_:TNijiaStar = null;
         var _loc7_:uint = 0;
         _loc3_ = param2 as TNijiaStarAtom;
         if(_loc3_.IsActivate)
         {
            EffectGenerateText(STRING_NIJIASTAR.STRING_NijiaStarActivated);
            return;
         }
         _loc6_ = this.FHero.NijiaStars.GetNijiaStarByIndex(this.FIndex);
         if(_loc6_.Identifier != 0 && _loc6_.Identifier + 1 < _loc3_.Identifier)
         {
            EffectGenerateText(STRING_NIJIASTAR.STRING_NijiaStarCannotActivated);
            return;
         }
         _loc4_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_NijiaStar_LevelUpReq);
         _loc5_ = _loc4_.Data;
         _loc7_ = uint(_loc3_.Identifier);
         _loc5_.writeUnsignedInt(this.FHero.Identifier);
         _loc5_.writeUnsignedInt(_loc7_);
         SNetworkCore.Transceiver.PacketTransmit(_loc4_);
      }
      
      protected function UIHelpTipsHintOnOver(param1:Object, param2:THint) : void
      {
         this.FOverlayerHelpTips.Context = param2;
         this.FOverlayerHelpTips.Render(FUICore.MouseCoordinate);
         this.FOverlayerHelpTips.Show();
      }
      
      protected function UIHelpTipsHintOnOut(param1:Object) : void
      {
         this.FOverlayerHelpTips.Hide();
      }
      
      protected function InitNijiaStar() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:ByteArray = null;
         var _loc5_:THeros = null;
         var _loc6_:THero = null;
         if(this.FIsInit)
         {
            return;
         }
         _loc4_ = new ByteArray();
         _loc5_ = SLogicsCore.Character.Heros;
         _loc5_.Sort();
         _loc3_ = this.CAPACITY_NijiaStar;
         _loc1_ = 0;
         while(_loc1_ < _loc5_.Count)
         {
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               _loc4_.writeInt(-1);
               _loc2_++;
            }
            _loc1_++;
         }
         _loc4_.position = 0;
         _loc1_ = 0;
         while(_loc1_ < _loc5_.Count)
         {
            _loc6_ = _loc5_.GetHeroByIndex(_loc1_);
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               this.FUnstreamizerNijiaStar.Unstreamize(_loc4_,_loc6_.NijiaStars,_loc2_);
               _loc2_++;
            }
            _loc1_++;
         }
         this.FIsInit = true;
      }
      
      public function get OnReturnMainScene() : Function
      {
         return this.FOnReturnMainScene;
      }
      
      public function set OnReturnMainScene(param1:Function) : void
      {
         this.FOnReturnMainScene = param1;
      }
      
      public function get GetKingSoulOnClick() : Function
      {
         return this.FGetKingSoulOnClick;
      }
      
      public function set GetKingSoulOnClick(param1:Function) : void
      {
         this.FGetKingSoulOnClick = param1;
      }
      
      public function get OnUpdateHerosBaseAttributeReq() : Function
      {
         return this.FOnUpdateHerosBaseAttributeReq;
      }
      
      public function set OnUpdateHerosBaseAttributeReq(param1:Function) : void
      {
         this.FOnUpdateHerosBaseAttributeReq = param1;
      }
      
      public function get OnUserTotalFightingPowerReq() : Function
      {
         return this.FOnUserTotalFightingPowerReq;
      }
      
      public function set OnUserTotalFightingPowerReq(param1:Function) : void
      {
         this.FOnUserTotalFightingPowerReq = param1;
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowNijiaStar.Load();
            this.FProcessorWindowMainPoint.Load();
            this.FProcessorWindowNijiaStarExchange.Load();
            return;
         }
         this.InitNijiaStar();
         this.FProcessorWindowNijiaStar.Visible = true;
         this.FProcessorWindowNijiaStar.UpdateUI();
         this.FProcessorWindowMainPoint.Visible = false;
         this.PacketPerform_CS_NijiaSoulUpdateReq();
         if(this.FIsNeedRequest)
         {
            this.PacketPerform_C2S_StarUpdateReq();
            this.FIsNeedRequest = false;
         }
      }
   }
}

