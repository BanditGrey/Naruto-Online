package Processors.Game.Lobby.SevenKing
{
   import Foundation.Common.*;
   import Foundation.Network.*;
   import Foundation.Resources.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.*;
   import Logics.Characters.*;
   import Logics.DatebaseVO.VO.*;
   import Logics.Inventories.TInventory;
   import Logics.SevenKing.*;
   import Processors.Game.Lobby.Common.*;
   import Processors.Game.Lobby.Common.Shortcuts.*;
   import Rendering.Overlayers.*;
   import Rendering.Overlayers.HelpTips.*;
   import Rendering.Overlayers.Hints.*;
   import Rendering.Overlayers.Inventories.TOverlayerAppliance;
   import Rendering.Overlayers.NijiaStar.*;
   import Resources.Constants.CONST_BATTLE;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_INVENTORY;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SEVENKING;
   import Resources.Constants.CONST_SHORTCUTS;
   import Resources.Strings.*;
   import Utilities.UI.Overlayers.*;
   import flash.display.*;
   import flash.events.MouseEvent;
   import flash.utils.*;
   import ghostcat.util.data.*;
   
   public class TProcessorSevenKing extends TProcessorLobbyPlate
   {
      
      public static const CAPACITY_INVENTORIES:uint = CONST_COMMON.CAPACITY_INVENTORIES;
      
      public static const CATEGORY_Normal:uint = CONST_INVENTORY.CATEGORY_Normal;
      
      public static const CATEGORY_Equipment:uint = CONST_INVENTORY.CATEGORY_Equipment;
      
      public static const CATEGORY_Gem:uint = CONST_INVENTORY.CATEGORY_Gem;
      
      public static const CATEGORY_Treasure:uint = CONST_INVENTORY.CATEGORY_Treasure;
      
      public static const CATEGORY_Material:uint = CONST_INVENTORY.CATEGORY_Material;
      
      public static const CATEGORY_Accessories:uint = CONST_INVENTORY.CATEGORY_Accessories;
      
      protected var FScene:MovieClip;
      
      protected var FProcessorWindowSevenKing:TProcessorWindowSevenKing;
      
      protected var FProcessorWindowSevenHeros:TProcessorWindowSevenHeros;
      
      protected var FProcessorWindowHeroSelect:TProcessorWindowHeroSelect;
      
      protected var FProcessorWindowFightResult:TProcessorWindowFightResult;
      
      protected var FProcessorWindowNinjaStarExchange:TProcessorWindowNinjaStarExchange;
      
      protected var FMountPointWindow:TUIComponent;
      
      protected var FOverlayerHint:TOverlayerHint;
      
      protected var FOverlayerHelpTips:TOverlayerHelpTips;
      
      protected var FOverLayerKingSoul:TOverLayerKingSoul;
      
      protected var FOverlayerAppliance:TOverlayerAppliance;
      
      protected var FSevenKingData:TSevenKingData;
      
      protected var FCharacter:TCharacter;
      
      protected var FSevenHeroArmy:TSevenHeroArmy;
      
      protected var FNijiaStarBtn:SimpleButton;
      
      protected var FBTN_ExchangeNijiaStar:SimpleButton;
      
      protected var FBattleBack:Boolean;
      
      protected var FOnReturnMainScene:Function;
      
      protected var FOnInitBattle:Function;
      
      protected var FSetStatusType:Function;
      
      protected var FOnShortcutHyperlinks:Function;
      
      public function TProcessorSevenKing(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FSevenKingData = new TSevenKingData();
         this.FCharacter = SLogicsCore.Character;
         this.FMountPointWindow = param2.MountPointWindow;
         this.FBattleBack = false;
         SetUIModuleID(CONST_MODULES.MODULE_SevenKing);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_SEVENKING.RESOURCESID_SEVENKING);
         SResourcesCore.TexturesSwfCommon.LoadPrimary(CONST_COMMON.RESOURCESID_Swf_Common);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:TConfigValue = null;
         this.FScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_SEVENKING.RESOURCESID_CLASSNAME_SevenKing) as MovieClip;
         addChild(this.FScene);
         this.FNijiaStarBtn = this.FScene.Btn_NijiaStar;
         if(this.FNijiaStarBtn != null)
         {
            this.FNijiaStarBtn.addEventListener(MouseEvent.CLICK,this.OnGotoNijiaStar);
         }
         this.FBTN_ExchangeNijiaStar = this.FScene.BTN_ExchangeNijiaStar;
         if(this.FBTN_ExchangeNijiaStar != null)
         {
            _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,91000018) as TConfigValue;
            this.FBTN_ExchangeNijiaStar.addEventListener(MouseEvent.CLICK,this.OnGotoExchangeNinjaStar);
            this.FBTN_ExchangeNijiaStar.visible = _loc1_.Value == 0 ? false : true;
         }
         this.FProcessorWindowSevenKing = new TProcessorWindowSevenKing(this,this.FScene.mc_publicBox);
         this.FProcessorWindowSevenKing.HintOnMove = this.UIComponentsHintOnOver;
         this.FProcessorWindowSevenKing.HintOnOut = this.UIComponentsHintOnOut;
         this.FProcessorWindowSevenKing.OnHelpTipsOver = this.UIHelpTipsHintOnOver;
         this.FProcessorWindowSevenKing.OnHelpTipsOut = this.UIHelpTipsHintOnOut;
         this.FProcessorWindowSevenKing.OnEnterCity = this.OnCloseTavern;
         this.FProcessorWindowSevenKing.EffectGenerateText = EffectGenerateText;
         this.FProcessorWindowSevenKing.UIComponentsOnOver = this.UIComponentsOverlayerOnOver;
         this.FProcessorWindowSevenKing.UIComponentsOnOut = this.UIComponentsOverlayerOnOut;
         this.FProcessorWindowSevenHeros = new TProcessorWindowSevenHeros(this,this.FScene,this.FSevenKingData);
         this.FProcessorWindowSevenHeros.SelectHeroFight = this.SelectHeroFight;
         this.FProcessorWindowSevenHeros.UIComponentsOnOver = this.UIComponentsOverlayerOnOver;
         this.FProcessorWindowSevenHeros.UIComponentsOnOut = this.UIComponentsOverlayerOnOut;
         this.FProcessorWindowSevenHeros.UIHintOnOver = this.UIComponentsHintOnOver;
         this.FProcessorWindowSevenHeros.UIHintOnOut = this.UIComponentsHintOnOut;
         this.FProcessorWindowHeroSelect = new TProcessorWindowHeroSelect(this,this.FSevenKingData);
         this.FProcessorWindowHeroSelect.Visible = false;
         this.FProcessorWindowFightResult = new TProcessorWindowFightResult(this);
         this.FProcessorWindowFightResult.Visible = false;
         this.FProcessorWindowFightResult.ChangeHero = this.ProcessorChangeHero;
         this.FProcessorWindowNinjaStarExchange = new TProcessorWindowNinjaStarExchange(this);
         this.FProcessorWindowNinjaStarExchange.OnOverlay = this.UIComponentsItemOnOver;
         this.FProcessorWindowNinjaStarExchange.OnOut = this.UIComponentsItemOnOut;
         this.FProcessorWindowNinjaStarExchange.x = (CONST_COMMON.STAGE_Width - 670) / 2;
         this.FProcessorWindowNinjaStarExchange.y = (CONST_COMMON.STAGE_Height - 486) / 2;
         this.FProcessorWindowNinjaStarExchange.Init(this.FSevenKingData);
         this.FProcessorWindowNinjaStarExchange.Visible = false;
         this.FOverlayerHint = new TOverlayerHint(this.FMountPointWindow);
         this.FOverlayerHint.Visible = false;
         this.FOverlayerHelpTips = new TOverlayerHelpTips(this.FMountPointWindow);
         this.FOverlayerHelpTips.visible = false;
         this.FOverLayerKingSoul = new TOverLayerKingSoul(this.FMountPointWindow);
         this.FOverLayerKingSoul.visible = false;
         this.FOverlayerAppliance = new TOverlayerAppliance(this.FMountPointWindow,CONST_MODULES.MODULE_SevenKing);
         this.FOverlayerAppliance.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerHint);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerHelpTips);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverLayerKingSoul);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerAppliance);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(this.FProcessorWindowSevenKing != null && Visible == true)
         {
            this.FProcessorWindowSevenKing.UpdataEffect();
         }
         if(this.FProcessorWindowSevenHeros != null && Visible == true)
         {
            this.FProcessorWindowSevenHeros.UpdataHeroActive();
         }
         if(this.FProcessorWindowHeroSelect != null && this.FProcessorWindowHeroSelect.Visible == true)
         {
            this.FProcessorWindowHeroSelect.ShowHeroHead();
         }
         if(this.FProcessorWindowNinjaStarExchange != null && this.FProcessorWindowNinjaStarExchange.Visible)
         {
            this.FProcessorWindowNinjaStarExchange.LogicsPerform();
         }
      }
      
      protected function EnterSevenKing() : void
      {
         this.FProcessorWindowSevenKing.UpdataPublicUI();
         this.FProcessorWindowSevenHeros.UpdataUI();
         this.FProcessorWindowHeroSelect.Visible = false;
      }
      
      protected function SelectHeroFight(param1:Object, param2:TSevenHeroArmy) : void
      {
         this.FSevenHeroArmy = param2;
         this.FProcessorWindowHeroSelect.SetHeroFight(param2);
         this.FProcessorWindowHeroSelect.Visible = true;
         this.FProcessorWindowHeroSelect.ReportReq();
      }
      
      protected function ProcessorChangeHero(param1:Object) : void
      {
         this.FProcessorWindowHeroSelect.Visible = true;
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_SevenKing_FightRet,this.PacketPerform_SC_FightRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_SevenKing_RespectRet,this.PacketPerform_SC_RespectRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_SevenKing_ReportRet,this.PacketPerform_SC_ReportRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_SevenKing_ResetNotify,this.PacketPerform_SC_ResetNotif);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_SevenKing_ReportNotify,this.PacketPerform_SC_ReportNotify);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_SevenKing_ExchangeRet,this.PacketPerform_SC_ExchangeRet);
      }
      
      protected function PacketPerform_SC_Enter_SevenKing(param1:ByteArray) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         this.FSevenKingData.CurBattleTimes = param1.readUnsignedShort();
         this.FSevenKingData.CurProgressFlag = param1.readUnsignedInt();
         _loc3_ = param1.readUnsignedShort();
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            this.FSevenKingData.RespectInfo[_loc2_ + 1] = param1.readUnsignedByte();
            _loc2_++;
         }
         _loc3_ = param1.readUnsignedShort();
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            this.FCharacter.SetKingSoulByIndex(_loc2_,param1.readUnsignedInt());
            _loc2_++;
         }
         this.EnterSevenKing();
      }
      
      protected function PacketPerform_SC_FightRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:Boolean = false;
         var _loc5_:Boolean = false;
         var _loc6_:Object = null;
         var _loc7_:uint = 0;
         var _loc8_:String = null;
         var _loc9_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         if(this.FSetStatusType != null)
         {
            this.FSetStatusType(this,CONST_BATTLE.BattleType_SevenKing,0);
         }
         if(this.FOnInitBattle != null)
         {
            this.FOnInitBattle(this);
         }
         ++this.FSevenKingData.CurBattleTimes;
         _loc4_ = Boolean(_loc2_.readUnsignedByte());
         _loc5_ = Boolean(_loc2_.readUnsignedByte());
         this.FProcessorWindowFightResult.SetResult(_loc4_,_loc5_,this.FSevenHeroArmy);
         this.FProcessorWindowFightResult.Visible = true;
         if(_loc4_ && !_loc5_)
         {
            _loc6_ = Json.decode(this.FSevenHeroArmy.ManyWinReward);
            _loc9_ = uint(_loc6_[0].code);
            _loc7_ = this.FCharacter.GetKingSoulByIndex(_loc9_ - 8);
            this.FProcessorWindowSevenKing.SetHeroSoulByIndex(_loc9_ - 8,_loc7_ + _loc6_[0].amount);
            this.FCharacter.SetKingSoulByIndex(_loc9_ - 8,_loc7_ + _loc6_[0].amount);
            ++this.FSevenKingData.CurProgressFlag;
            this.FProcessorWindowSevenHeros.UpdataUI();
            _loc8_ = TUtilityString.Format(STRING_SEVENHEROS.FORMAT_DefeatEnemy,STRING_COMMON.STRING_KingSouls[_loc9_ > 8 ? _loc9_ - 9 : STRING_COMMON.STRING_KingSouls.length - 1],_loc6_[0].amount);
            EffectGenerateText(_loc8_);
         }
         ProcessorOnCheckIconStatus(CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_SevenKing,this.FSevenKingData.CheckStatus());
      }
      
      protected function PacketPerform_SC_RespectRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:String = null;
         var _loc8_:Boolean = false;
         var _loc9_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc9_ = _loc4_ = _loc2_.readUnsignedInt();
         _loc5_ = _loc2_.readUnsignedInt();
         _loc6_ = _loc2_.readUnsignedInt();
         _loc8_ = Boolean(_loc2_.readUnsignedByte());
         _loc9_ = _loc9_ % 100 >= CONST_COMMON.CAPACITY_KingSouls ? uint(CONST_COMMON.KINGSOULINDEX_Common) : uint(_loc9_ % 100);
         this.FSevenKingData.RespectInfo[this.FProcessorWindowSevenHeros.SelectKingIndex + 1] += this.FProcessorWindowSevenHeros.RespectCount;
         this.FProcessorWindowSevenKing.SetHeroSoulByIndex(_loc9_,this.FCharacter.GetKingSoulByIndex(_loc9_) + _loc5_);
         this.FCharacter.SetKingSoulByIndex(_loc9_,this.FCharacter.GetKingSoulByIndex(_loc9_) + _loc5_);
         this.FProcessorWindowSevenHeros.UpdataUI();
         this.UIComponentsHintOnOut(null);
         if(_loc8_)
         {
            if(_loc6_ != 0)
            {
               _loc7_ = TUtilityString.Format(STRING_SEVENHEROS.FORMAT_OneKeyPractiseCritical,_loc6_,STRING_COMMON.STRING_KingSouls[_loc4_ % 100 - 1],_loc5_);
            }
            else
            {
               _loc7_ = TUtilityString.Format(STRING_SEVENHEROS.FORMAT_OneKeyPractise,STRING_COMMON.STRING_KingSouls[_loc4_ % 100 - 1],_loc5_);
            }
         }
         else if(_loc6_ != 0)
         {
            _loc7_ = TUtilityString.Format(STRING_SEVENHEROS.FORMAT_RespectCritical,STRING_COMMON.STRING_KingSouls[_loc4_ % 100 - 1],_loc5_);
         }
         else
         {
            _loc7_ = TUtilityString.Format(STRING_SEVENHEROS.FORMAT_Respect,STRING_COMMON.STRING_KingSouls[_loc4_ % 100 - 1],_loc5_);
         }
         EffectGenerateText(_loc7_);
         ProcessorOnCheckIconStatus(CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_SevenKing,this.FSevenKingData.CheckStatus());
      }
      
      protected function PacketPerform_SC_ReportRet(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:ByteArray = null;
         var _loc4_:uint = 0;
         _loc3_ = param1.Data;
         _loc4_ = _loc3_.readUnsignedShort();
         _loc2_ = 0;
         while(_loc2_ < _loc4_)
         {
            this.FSevenKingData.ReportUserName[_loc2_] = TUtilityString.FetchUTF(_loc3_);
            this.FSevenKingData.ReportID[_loc2_] = TUtilityString.FetchUTF(_loc3_);
            _loc2_++;
         }
         this.FProcessorWindowHeroSelect.UpdataReport();
      }
      
      protected function PacketPerform_SC_ResetNotif(param1:TPacket) : void
      {
         this.FSevenKingData.Reset();
         if(this.Visible)
         {
            this.FProcessorWindowSevenHeros.UpdataUI();
         }
      }
      
      protected function PacketPerform_SC_ReportNotify(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:String = null;
         var _loc5_:String = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedByte();
         _loc4_ = TUtilityString.FetchUTF(_loc2_);
         _loc5_ = TUtilityString.FetchUTF(_loc2_);
         this.FSevenKingData.ReportUserName[_loc3_ - 1] = _loc4_;
         this.FSevenKingData.ReportID[_loc3_ - 1] = _loc5_;
         if(this.Visible)
         {
            this.FProcessorWindowHeroSelect.UpdataReport();
         }
      }
      
      protected function PacketPerform_SC_ExchangeRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:int = 0;
         var _loc5_:TConfigValue = null;
         var _loc6_:Vector.<Object> = null;
         var _loc7_:Object = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc4_ = int(_loc2_.readUnsignedInt());
         _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.SERVEN_HERO_EXCHANGE_RULE) as TConfigValue;
         _loc6_ = _loc5_.Value as Vector.<Object>;
         _loc7_ = _loc6_[_loc4_];
         _loc8_ = int(this.FCharacter.GetKingSoulByType(_loc7_["fr_soultype"]));
         _loc9_ = int(_loc7_["fr_itemcnt"]);
         this.FCharacter.SetKingSoulByType(_loc7_["fr_soultype"],_loc8_ - _loc9_);
         _loc8_ = int(this.FCharacter.GetKingSoulByType(_loc7_["to_soultype"]));
         _loc9_ = int(_loc7_["to_itemcnt"]);
         this.FCharacter.SetKingSoulByType(_loc7_["to_soultype"],_loc8_ + _loc9_);
         if(FOnEffectText != null)
         {
            FOnEffectText(this,STRING_BASEACTIVITY.FORMAT_EXCHANGE);
         }
         if(this.FProcessorWindowNinjaStarExchange.Visible)
         {
            this.FProcessorWindowNinjaStarExchange.UpdateUI();
            this.FProcessorWindowSevenKing.UpdataPublicUI();
         }
      }
      
      protected function UIComponentsHintOnOver(param1:Object, param2:THint) : void
      {
         this.FOverlayerHint.Context = param2;
         this.FOverlayerHint.Render(FUICore.MouseCoordinate);
         this.FOverlayerHint.Visible = true;
      }
      
      protected function UIComponentsHintOnOut(param1:Object) : void
      {
         this.FOverlayerHint.Visible = false;
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
      
      protected function OnCloseTavern(param1:Object) : void
      {
         if(this.FOnReturnMainScene != null)
         {
            this.FOnReturnMainScene(param1);
         }
      }
      
      protected function UIComponentsItemOnOver(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = null;
         var _loc4_:TOverlayer = null;
         _loc3_ = param2 as TInventory;
         var _loc5_:uint = _loc3_.Category;
         switch(0)
         {
         }
         _loc4_ = this.FOverlayerAppliance;
         if(_loc4_ != null)
         {
            _loc4_.Context = _loc3_;
            _loc4_.Render(FUICore.MouseCoordinate);
            _loc4_.Show();
         }
      }
      
      protected function UIComponentsItemOnOut(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = null;
         var _loc4_:TOverlayer = null;
         if(param2 == null)
         {
            if(this.FOverlayerAppliance.visible)
            {
               this.FOverlayerAppliance.Hide();
            }
            return;
         }
         _loc3_ = param2 as TInventory;
         var _loc5_:uint = _loc3_.Category;
         switch(0)
         {
         }
         _loc4_ = this.FOverlayerAppliance;
         if(_loc4_ != null)
         {
            _loc4_.Hide();
         }
      }
      
      protected function UIComponentsOverlayerOnOver(param1:Object, param2:Object) : void
      {
         var _loc3_:TOverlayer = null;
         var _loc4_:TSevenHeroDailyAward = null;
         var _loc5_:TSevenHeroSoul = null;
         _loc3_ = this.FOverLayerKingSoul;
         if(param2 is TSevenHeroDailyAward)
         {
            _loc4_ = param2 as TSevenHeroDailyAward;
            _loc3_.Context = _loc4_;
         }
         else if(param2 is TSevenHeroSoul)
         {
            _loc5_ = param2 as TSevenHeroSoul;
            _loc3_.Context = _loc5_;
         }
         _loc3_ = this.FOverLayerKingSoul;
         if(_loc3_ != null)
         {
            _loc3_.Render(FUICore.MouseCoordinate);
            _loc3_.CoordinateOverlay.X -= _loc3_.BoundsSubstrate.Width + 20;
            _loc3_.Show();
         }
      }
      
      protected function UIComponentsOverlayerOnOut(param1:Object) : void
      {
         var _loc2_:TOverlayer = null;
         _loc2_ = this.FOverLayerKingSoul;
         if(_loc2_ != null)
         {
            _loc2_.Hide();
         }
      }
      
      protected function PacketPerform_CS_Enter_SevenKing() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Enter_SevenKing);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function OnGotoNijiaStar(param1:MouseEvent) : void
      {
         if(this.FOnShortcutHyperlinks != null)
         {
            this.FOnShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_NijiaStar);
         }
      }
      
      protected function OnGotoExchangeNinjaStar(param1:MouseEvent) : void
      {
         this.FProcessorWindowNinjaStarExchange.Visible = true;
      }
      
      public function get OnReturnMainScene() : Function
      {
         return this.FOnReturnMainScene;
      }
      
      public function set OnReturnMainScene(param1:Function) : void
      {
         this.FOnReturnMainScene = param1;
      }
      
      public function get OnInitBattle() : Function
      {
         return this.FOnInitBattle;
      }
      
      public function set OnInitBattle(param1:Function) : void
      {
         this.FOnInitBattle = param1;
      }
      
      public function get SetStatusType() : Function
      {
         return this.FSetStatusType;
      }
      
      public function set SetStatusType(param1:Function) : void
      {
         this.FSetStatusType = param1;
      }
      
      public function get OnShortcutHyperlinks() : Function
      {
         return this.FOnShortcutHyperlinks;
      }
      
      public function set OnShortcutHyperlinks(param1:Function) : void
      {
         this.FOnShortcutHyperlinks = param1;
      }
      
      public function set BattleBack(param1:Boolean) : void
      {
         this.FBattleBack = param1;
      }
      
      public function get BattleBack() : Boolean
      {
         return this.FBattleBack;
      }
      
      override public function ShortcutModesSetup(param1:TLobbyShortcutModes) : void
      {
         var _loc2_:TLobbyShortcutAvatarModes = null;
         var _loc3_:TLobbyShortcutActivityModes = null;
         var _loc4_:TLobbyShortcutActiveSpecialModes = null;
         var _loc5_:TLobbyShortcutFunctionModes = null;
         var _loc6_:TLobbyShortcutMapModes = null;
         var _loc7_:TLobbyShortcutQuestGuideModes = null;
         var _loc8_:TLobbyShortcutConstantlyModes = null;
         if(param1 is TLobbyShortcutAvatarModes)
         {
            _loc2_ = param1 as TLobbyShortcutAvatarModes;
            _loc2_.ShortcutModeAvatar = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         }
         if(param1 is TLobbyShortcutActivityModes)
         {
            _loc3_ = param1 as TLobbyShortcutActivityModes;
            _loc3_.SetAllShortcutHide();
         }
         if(param1 is TLobbyShortcutActiveSpecialModes)
         {
            _loc4_ = param1 as TLobbyShortcutActiveSpecialModes;
            _loc4_.ShortcutModeCDK = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         }
         if(param1 is TLobbyShortcutFunctionModes)
         {
            _loc5_ = param1 as TLobbyShortcutFunctionModes;
            _loc5_.ShortcutModeHero = TLobbyShortcutMode.SHORTCUTMODE_Show;
            _loc5_.ShortcutModeStar = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc5_.ShortcutModeTacticalDeployment = TLobbyShortcutMode.SHORTCUTMODE_Show;
            _loc5_.ShortcutModeInheritPractice = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc5_.ShortcutModeBackpack = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc5_.ShortcutModeTreasure = TLobbyShortcutMode.SHORTCUTMODE_Show;
            _loc5_.ShortcutModeSummonPet = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc5_.ShortcutModeStrengthen = TLobbyShortcutMode.SHORTCUTMODE_Show;
            _loc5_.ShortcutModeMail = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc5_.ShortcutModeTongLing = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc5_.ShortcutModeOrganiZation = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc5_.ShortcutModeReturn = TLobbyShortcutMode.SHORTCUTMODE_Show;
         }
         if(param1 is TLobbyShortcutMapModes)
         {
            _loc6_ = param1 as TLobbyShortcutMapModes;
            _loc6_.ShortcutModeMap = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc6_.ShortcutModeReturnHome = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         }
         if(param1 is TLobbyShortcutQuestGuideModes)
         {
            _loc7_ = param1 as TLobbyShortcutQuestGuideModes;
            _loc7_.ShortcutMode = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         }
         if(param1 is TLobbyShortcutConstantlyModes)
         {
            _loc8_ = param1 as TLobbyShortcutConstantlyModes;
            _loc8_.ShortcutModeStrengthen = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc8_.ShortcutModeArena = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc8_.ShortcutModeBigDipper = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc8_.ShortcutModeMentorship = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc8_.ShortcutModeTongLing = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         }
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         if(this.FBattleBack)
         {
            this.FBattleBack = false;
            return;
         }
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.FCharacter.RoleSencePosition = CONST_COMMON.SCENEPOSITION_SevenKing;
         this.PacketPerform_CS_Enter_SevenKing();
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
      }
      
      public function SetInitInfo(param1:ByteArray) : void
      {
         this.PacketPerform_SC_Enter_SevenKing(param1);
      }
   }
}

