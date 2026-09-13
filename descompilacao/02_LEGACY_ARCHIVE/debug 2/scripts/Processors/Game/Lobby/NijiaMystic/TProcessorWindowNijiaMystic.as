package Processors.Game.Lobby.NijiaMystic
{
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Logics.Characters.TCharacter;
   import Logics.DatebaseVO.VO.TNijiaMystic;
   import Logics.NijiaMystic.TNijiaMysticData;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.NijiaMystic.Components.TProcessorMysticItem;
   import Rendering.Overlayers.Hints.TOverlayerHint;
   import Rendering.Overlayers.NijiaMystic.TOverlayerNijiaMystic;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_NIJIAMYSTIC;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class TProcessorWindowNijiaMystic extends TUIComponent
   {
      
      protected static const MAX_MATERIAL:uint = 9;
      
      protected static const MAX_MYSTIC:uint = 8;
      
      protected var FScene:MovieClip;
      
      protected var FMC_EffectLeft:MovieClip;
      
      protected var FMC_EffectRight:MovieClip;
      
      protected var FBtn_GotoCollect:MovieClip;
      
      protected var FHeadIconBitmap:Bitmap;
      
      protected var FMysticMaterialVect:Vector.<TextField>;
      
      protected var FMysticItemVect:Vector.<TProcessorMysticItem>;
      
      protected var FTF_SelectMysticName:TextField;
      
      protected var FSelectMysticIcon:MovieClip;
      
      protected var FCharacter:TCharacter;
      
      protected var FNijiaMysticData:TNijiaMysticData;
      
      protected var FOverlayerNijiaMystic:TOverlayerNijiaMystic;
      
      protected var FOverlayerHint:TOverlayerHint;
      
      protected var FHint:THint;
      
      protected var FGotoCollect:Function;
      
      public function TProcessorWindowNijiaMystic(param1:TUIComponent)
      {
         super(param1);
         this.FNijiaMysticData = SLogicsCore.NijiaMysticData;
         this.FHeadIconBitmap = new Bitmap();
         this.FMysticItemVect = new Vector.<TProcessorMysticItem>(MAX_MYSTIC);
         this.FMysticMaterialVect = new Vector.<TextField>(MAX_MATERIAL);
         this.FHint = new THint();
      }
      
      protected function InitResource() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         var _loc5_:TextField = null;
         var _loc6_:TProcessorMysticItem = null;
         var _loc7_:MovieClip = null;
         this.FMC_EffectLeft = this.FScene[CONST_NIJIAMYSTIC.RESOURCE_MC_EffectLeft];
         this.FMC_EffectRight = this.FScene[CONST_NIJIAMYSTIC.RESOURCE_MC_EffectRight];
         this.FBtn_GotoCollect = this.FScene[CONST_NIJIAMYSTIC.RESOURCE_BTN_GotoCollect];
         TGameUtil.setButtonMode(this.FBtn_GotoCollect,true);
         this.FBtn_GotoCollect.addEventListener(MouseEvent.CLICK,this.OnGotoCollect);
         this.FCharacter = SLogicsCore.Character;
         this.FScene[CONST_NIJIAMYSTIC.RESOURCE_TF_Name].text = this.FCharacter.NickName;
         this.FScene[CONST_NIJIAMYSTIC.RESOURCE_MC_LargeIcon].addChild(this.FHeadIconBitmap);
         this.FSelectMysticIcon = this.FScene[CONST_NIJIAMYSTIC.RESOURCE_MC_SelectMystic][CONST_NIJIAMYSTIC.RESOURCE_MC_Pic];
         this.FTF_SelectMysticName = this.FScene[CONST_NIJIAMYSTIC.RESOURCE_TF_SelectMysticName];
         this.FScene[CONST_NIJIAMYSTIC.RESOURCE_MC_SelectMystic].addEventListener(MouseEvent.CLICK,this.OnUnEquipMystic);
         this.FScene[CONST_NIJIAMYSTIC.RESOURCE_MC_SelectMystic].addEventListener(MouseEvent.MOUSE_MOVE,this.OnMysticMouseMove);
         this.FScene[CONST_NIJIAMYSTIC.RESOURCE_MC_SelectMystic].addEventListener(MouseEvent.ROLL_OUT,this.OnMysticMouseOut);
         _loc1_ = 0;
         while(_loc1_ < MAX_MYSTIC)
         {
            _loc3_ = this.FScene[CONST_NIJIAMYSTIC.RESOURCE_MC_Mystic + _loc1_];
            _loc6_ = new TProcessorMysticItem(this,_loc1_,_loc1_ + 1);
            _loc6_.OnMysticUpgrageHintMove = this.OnMysticUpgrageHintMove;
            _loc6_.OnMysticUpgrageHintOut = this.OnMysticUpgrageHintOut;
            _loc6_.OnMysticOver = this.OnMysticOver;
            _loc6_.OnMysticOut = this.OnMysticOut;
            _loc6_.SetScene(_loc3_);
            _loc6_.OnEquipMystic = this.OnEquipMystic;
            _loc6_.OnUpgradeMystic = this.OnUpgradeMystic;
            this.FMysticItemVect[_loc1_] = _loc6_;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < MAX_MATERIAL)
         {
            _loc4_ = this.FScene[CONST_NIJIAMYSTIC.RESOURCE_BTN_Material + _loc1_];
            _loc5_ = _loc4_[CONST_NIJIAMYSTIC.RESOURCE_TF_Count];
            this.FMysticMaterialVect[_loc1_] = _loc5_;
            _loc7_ = _loc4_[CONST_NIJIAMYSTIC.RESOURCE_MC_Icon];
            _loc7_[CONST_NIJIAMYSTIC.RESOURCE_MC_Effect].visible = false;
            _loc7_.gotoAndStop(_loc1_ + 1);
            _loc1_++;
         }
         this.FOverlayerNijiaMystic = new TOverlayerNijiaMystic(this.Parent.Parent);
         this.FOverlayerNijiaMystic.visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerNijiaMystic);
         this.FOverlayerHint = new TOverlayerHint(this.Parent.Parent);
         this.FOverlayerHint.visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerHint);
      }
      
      protected function OnGotoCollect(param1:MouseEvent) : void
      {
         if(this.FGotoCollect != null)
         {
            this.FGotoCollect(this);
         }
      }
      
      protected function OnUpgradeMystic(param1:Object, param2:uint) : void
      {
         var _loc3_:TPacket = null;
         var _loc4_:ByteArray = null;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_NijiaMystic_UpgradeReq);
         _loc4_ = _loc3_.Data;
         _loc4_.writeUnsignedInt(this.FNijiaMysticData.MysticIdVect[param2]);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      protected function OnEquipMystic(param1:Object, param2:uint) : void
      {
         var _loc3_:TPacket = null;
         var _loc4_:ByteArray = null;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_NijiaMystic_InstallReq);
         _loc4_ = _loc3_.Data;
         _loc4_.writeUnsignedInt(this.FNijiaMysticData.MysticIdVect[param2]);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      protected function OnUnEquipMystic(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         if(this.FNijiaMysticData.CurSelectMystic == 0)
         {
            return;
         }
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_NijiaMystic_InstallReq);
         _loc3_ = _loc2_.Data;
         _loc3_.writeUnsignedInt(0);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function OnMysticMouseMove(param1:MouseEvent) : void
      {
         var _loc2_:TNijiaMystic = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_NijiaMystic,this.FNijiaMysticData.CurSelectMystic) as TNijiaMystic;
         if(_loc2_ != null)
         {
            this.OnMysticOver(this,_loc2_);
         }
      }
      
      protected function OnMysticMouseOut(param1:MouseEvent) : void
      {
         this.OnMysticOut(this);
      }
      
      protected function OnMysticUpgrageHintMove(param1:Object, param2:String) : void
      {
         this.FHint.Caption = param2;
         this.FOverlayerHint.Context = this.FHint;
         this.FOverlayerHint.Render(FUICore.MouseCoordinate);
         this.FOverlayerHint.Show();
      }
      
      protected function OnMysticUpgrageHintOut(param1:Object) : void
      {
         this.FOverlayerHint.Hide();
      }
      
      protected function OnMysticOver(param1:Object, param2:TNijiaMystic) : void
      {
         this.FOverlayerNijiaMystic.Context = param2;
         this.FOverlayerNijiaMystic.Render(FUICore.MouseCoordinate);
         this.FOverlayerNijiaMystic.Show();
      }
      
      protected function OnMysticOut(param1:Object) : void
      {
         this.FOverlayerNijiaMystic.Hide();
      }
      
      public function get GotoCollect() : Function
      {
         return this.FGotoCollect;
      }
      
      public function set GotoCollect(param1:Function) : void
      {
         this.FGotoCollect = param1;
      }
      
      public function SetScene(param1:MovieClip) : void
      {
         this.FScene = param1;
         addChild(this.FScene);
         this.InitResource();
      }
      
      public function UpdataUI() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:TNijiaMystic = null;
         this.FScene[CONST_NIJIAMYSTIC.RESOURCE_TF_Level].text = SLogicsCore.Character.MainHero.GetLevelStrByLevel(this.FCharacter.GetMainLevel());
         _loc1_ = 0;
         while(_loc1_ < MAX_MYSTIC)
         {
            this.FMysticItemVect[_loc1_].SetData(this.FNijiaMysticData.MysticPointVect[_loc1_ + 1],this.FNijiaMysticData.MysticPointVect[0],this.FNijiaMysticData.MysticIdVect[_loc1_],this.FNijiaMysticData.CurSelectMystic);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < MAX_MATERIAL)
         {
            this.FMysticMaterialVect[_loc1_].text = String(this.FNijiaMysticData.MysticPointVect[_loc1_]);
            _loc1_++;
         }
         if(this.FNijiaMysticData.CurSelectMystic == 0)
         {
            this.FTF_SelectMysticName.text = "";
            this.FSelectMysticIcon.gotoAndStop(0);
         }
         else
         {
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_NijiaMystic,this.FNijiaMysticData.CurSelectMystic) as TNijiaMystic;
            this.FTF_SelectMysticName.text = _loc2_.Name;
            this.FSelectMysticIcon.gotoAndStop(_loc2_.OccultEffectKey + 2);
         }
      }
      
      public function Update() : void
      {
         TGameUtil.ShowImageByID(TGameUtil.Type_LargeIcon,this.FHeadIconBitmap,CONST_MODULES.MODULE_NinjaHostel,this.FCharacter.GetMainHero().LargeID);
      }
      
      override public function set Visible(param1:Boolean) : void
      {
         super.Visible = param1;
         if(this.FMC_EffectLeft != null)
         {
            this.FMC_EffectLeft.play();
         }
         if(this.FMC_EffectRight != null)
         {
            this.FMC_EffectRight.play();
         }
      }
   }
}

