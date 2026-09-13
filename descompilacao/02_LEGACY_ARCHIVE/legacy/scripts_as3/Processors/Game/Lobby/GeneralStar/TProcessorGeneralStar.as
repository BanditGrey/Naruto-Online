package Processors.Game.Lobby.GeneralStar
{
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Queries.Coordinate.TQueryCoordinate;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityCartisian;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.DatebaseVO.VO.TSkillConfig;
   import Logics.DatebaseVO.VO.TStarMap;
   import Logics.DatebaseVO.VO.TStarPoint;
   import Logics.DatebaseVO.VO.TStarPointDesc;
   import Logics.GeneralStar.TEsotericPoint;
   import Logics.GeneralStar.TEsotericPoints;
   import Logics.SLogicsCore;
   import Logics.Skills.TSkill;
   import Processors.Game.Common.Effects.Texts.TEffectCoordinateParameters;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Processors.Game.Lobby.GeneralStar.PackageStarPoint.TPoint;
   import Rendering.Overlayers.GeneralStar.TOverlayerGeneralStar;
   import Rendering.Overlayers.HelpTips.TOverlayerHelpTips;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_GENERAL_STAR;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_POPTIPS;
   import Resources.Constants.CONST_SHORTCUTS;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_TAVERN;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.utils.ByteArray;
   
   public class TProcessorGeneralStar extends TProcessorLobbyWindows
   {
      
      public static const FORMAT_SkillName:String = CONST_COMMON.STRING_ThinSquare;
      
      protected static const CAPACITY_ContextSkills:uint = 3;
      
      protected var FSpeed:uint = 11;
      
      protected var FHurtRate:uint = 28;
      
      protected var FRecoverRate:uint = 34;
      
      protected var FMAXHP:uint = 101;
      
      protected var FAvoidhurtRate:uint = 29;
      
      protected var FOverlayerGeneralStar:TOverlayerGeneralStar;
      
      protected var FProcessorWindowEsoteric:TProcessorWindowEsoteric;
      
      protected var FCharacter:TCharacter;
      
      protected var FEsotericPoints:TEsotericPoints;
      
      protected var FBoundsGeneralStar:TBounds;
      
      protected var FEffectCoordinateParameters:TEffectCoordinateParameters;
      
      protected var FQueryCoordinate:TQueryCoordinate;
      
      protected var FOnActivityBigDipper:Function;
      
      protected var FMainHeroQualityOnChange:Function;
      
      protected var FAddPopTips:Function;
      
      protected var FOnUpdateHerosBaseAttributeReq:Function;
      
      protected var FOnEffectAcquireInventory:Function;
      
      protected var FOnQueryShortcutCoordinate:Function;
      
      protected var FOnUserTotalFightingPowerReq:Function;
      
      protected var FOnTiaoZhuanClick:Function;
      
      protected var FOnShortcutHyperlinks:Function;
      
      public function TProcessorGeneralStar(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FCharacter = SLogicsCore.Character;
         this.FEsotericPoints = this.FCharacter.EsotericPoints;
         this.FBoundsGeneralStar = new TBounds();
         this.FBoundsGeneralStar.Width = 916;
         this.FBoundsGeneralStar.Height = 532;
         this.FProcessorWindowEsoteric = new TProcessorWindowEsoteric(this);
         this.FProcessorWindowEsoteric.OnClose = this.ProcessorWindowOnClose;
         this.FProcessorWindowEsoteric.OnHelpTipsOver = UIHelpTipsHintOnOver;
         this.FProcessorWindowEsoteric.OnHelpTipsOut = UIHelpTipsHintOnOut;
         this.FProcessorWindowEsoteric.OnPointMove = this.UIComponentsHintOnOver1;
         this.FProcessorWindowEsoteric.OnPointOut = this.UIComponentsHintOnOut1;
         this.FProcessorWindowEsoteric.OnPointClick = this.OnPointClick;
         this.FProcessorWindowEsoteric.OnTiaoZhuanClick = this.OnTiaoZhuanClickC;
         this.FProcessorWindowEsoteric.OnSetQuality = this.SetMainHeroQuality;
         this.FProcessorWindowEsoteric.OnActivityBigDipper = this.ProcessorOnOpenBigDipper;
         this.FProcessorWindowEsoteric.OnEffectText = ProcessorsOnEffectText;
         this.FProcessorWindowEsoteric.OnShortcutHyperlinks = this.ProcessorsOnShortcutHyperlinks;
         ComponentBoundsCenter(this.FProcessorWindowEsoteric,this.FBoundsGeneralStar);
         this.FOverlayerGeneralStar = new TOverlayerGeneralStar(this);
         this.FOverlayerGeneralStar.Visible = false;
         FOverlayerHelpTips = new TOverlayerHelpTips(this);
         FOverlayerHelpTips.Visible = false;
         this.FEffectCoordinateParameters = new TEffectCoordinateParameters();
         this.FQueryCoordinate = new TQueryCoordinate();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_GENERAL_STAR.RESOURCESID_GENERAL_STAR);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerGeneralStar);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHelpTips);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_GeneralStar_PointRet,this.PacketPerform_SC_GeneralStar_PointRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_GeneralStar_AwakenSoulRet,this.PacketPerform_SC_AwakenSoulRet);
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
      }
      
      private function PacketPerform_SC_GeneralStar_PointRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:TEsotericPoint = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = int(_loc2_.readUnsignedInt());
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.FCharacter.StarMapIndex = _loc2_.readUnsignedInt();
         _loc4_ = this.FEsotericPoints.GetEsotericPointByIdentifier(this.FCharacter.StarMapIndex) as TEsotericPoint;
         SLogicsCore.Character.AwakenGeneralsSoul -= _loc4_.NeedNewFetch;
         this.FloatingWords();
         if(_loc4_ != null)
         {
            _loc6_ = _loc4_.Type.length;
            _loc5_ = 0;
            while(_loc5_ < _loc6_)
            {
               if(_loc4_.Type[_loc5_] == this.FSpeed || _loc4_.Type[_loc5_] == this.FHurtRate || _loc4_.Type[_loc5_] == this.FRecoverRate || _loc4_.Type[_loc5_] == this.FMAXHP || _loc4_.Type[_loc5_] == this.FAvoidhurtRate)
               {
                  this.FEsotericPoints.SetFormationBonus(_loc4_.Target[_loc5_],_loc4_.Value[_loc5_],_loc4_.Type[_loc5_]);
               }
               _loc5_++;
            }
         }
         this.FProcessorWindowEsoteric.updatePoint();
         TutorialNextStep(701);
         if(this.FOnUpdateHerosBaseAttributeReq != null)
         {
            this.FOnUpdateHerosBaseAttributeReq(this);
         }
         if(this.FOnUserTotalFightingPowerReq != null)
         {
            this.FOnUserTotalFightingPowerReq(this);
         }
      }
      
      private function PacketPerform_SC_AwakenSoulRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:TEsotericPoint = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         _loc2_ = param1.Data;
         SLogicsCore.Character.AwakenGeneralsSoul = _loc2_.readUnsignedInt();
         this.FProcessorWindowEsoteric.init();
         this.FProcessorWindowEsoteric.Visible = true;
         TutorialNextStep(700);
      }
      
      protected function ProcessorOnOpenBigDipper(param1:Object) : void
      {
         this.FOnActivityBigDipper(this);
      }
      
      protected function SetMainHeroQuality() : void
      {
         var _loc1_:TStarPoint = null;
         var _loc2_:int = 0;
         var _loc3_:TStarMap = null;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_StarPoint,this.FCharacter.StarMapIndex) as TStarPoint;
         _loc2_ = _loc1_.MapId + 1;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_StarMap,_loc2_ + 17200000) as TStarMap;
         this.FCharacter.MainHero.Quality = _loc3_.Quality;
         if(this.FCharacter.EsotericPoints.GetEsotericPointByIdentifier(this.FCharacter.StarMapIndex) == this.FCharacter.EsotericPoints.GetEsotericPointByIndex(74))
         {
            this.FCharacter.MainHero.Quality = _loc3_.Quality + 1;
         }
         if(this.FMainHeroQualityOnChange != null)
         {
            this.FMainHeroQualityOnChange(this);
         }
      }
      
      protected function FloatingWords() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:Array = null;
         var _loc6_:TEsotericPoint = null;
         var _loc7_:TSkillConfig = null;
         var _loc8_:TSkill = null;
         var _loc9_:TStarPointDesc = null;
         var _loc10_:String = null;
         var _loc11_:String = null;
         var _loc12_:String = null;
         var _loc13_:String = null;
         var _loc14_:uint = 0;
         _loc6_ = this.FEsotericPoints.GetEsotericPointByIdentifier(this.FCharacter.StarMapIndex) as TEsotericPoint;
         _loc3_ = _loc6_.IsSkill;
         _loc4_ = "";
         _loc13_ = "";
         _loc2_ = int(CAPACITY_ContextSkills);
         if(_loc3_ == 0)
         {
            _loc2_ = int(_loc6_.Type.length);
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               _loc10_ = STRING_COMMON.TargetName[_loc6_.Target[_loc1_] - 1];
               _loc9_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_StarPointDesc,17500000 + _loc6_.Type[_loc1_]) as TStarPointDesc;
               _loc11_ = _loc9_.Desc;
               _loc12_ = _loc6_.Value[_loc1_].toString();
               if(_loc6_.Type[_loc1_] >= 100)
               {
                  _loc14_ = _loc6_.Value[_loc1_] * 100;
                  _loc12_ = _loc14_.toString() + "%";
               }
               _loc13_ += _loc10_ + _loc11_ + "+" + _loc12_ + "\n";
               _loc1_++;
            }
            EffectGenerateText(_loc13_);
         }
         else
         {
            _loc7_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SkillConfig,_loc6_.Value[0]) as TSkillConfig;
            _loc13_ = TUtilityString.Format(FORMAT_SkillName,_loc7_.Name);
            EffectGenerateText(STRING_TAVERN.Congratulate + _loc13_);
            this.PlayEfffect();
         }
      }
      
      private function PlayEfffect() : void
      {
         var _loc1_:TSkillConfig = null;
         var _loc2_:TSkill = null;
         var _loc3_:TPoint = null;
         var _loc4_:TEsotericPoint = null;
         var _loc5_:uint = 0;
         _loc4_ = this.FEsotericPoints.GetEsotericPointByIdentifier(this.FCharacter.StarMapIndex) as TEsotericPoint;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SkillConfig,_loc4_.Value[0]) as TSkillConfig;
         _loc2_ = SLogicsCore.PoolSkill.Acquire(_loc1_.Identifier);
         _loc2_.IDTexture = _loc1_.Icon;
         _loc5_ = _loc4_.MapNum - Math.floor(_loc4_.MapNum / 10) * 10 - 2;
         _loc3_ = this.FProcessorWindowEsoteric.GetGroundByIndex(_loc5_).GetPointByIndex(_loc4_.PointIndex - 1);
         this.ProcessorEffectAcquireInventory(_loc3_,_loc2_);
      }
      
      protected function ProcessorEffectAcquireInventory(param1:TPoint, param2:TSkill) : void
      {
         var _loc3_:TCoordinate = null;
         if(this.FOnQueryShortcutCoordinate != null)
         {
            this.FOnQueryShortcutCoordinate(this,CONST_SHORTCUTS.POSITION_Function,CONST_SHORTCUTS.TYPE_Function_TacticalDeployment,this.FQueryCoordinate);
         }
         _loc3_ = TUtilityCartisian.GetScreenCoordinateByDisplayObject(param1.Substrate);
         _loc3_.X += (param1.Substrate.width - 48) / 2;
         _loc3_.Y += (param1.Substrate.height - 48) / 2;
         this.FEffectCoordinateParameters.CoordinateSource.Assign(_loc3_);
         this.FEffectCoordinateParameters.CoordinateDestination.Assign(this.FQueryCoordinate.Value);
         if(this.FOnEffectAcquireInventory != null)
         {
            this.FOnEffectAcquireInventory(this,param2,this.FEffectCoordinateParameters);
         }
      }
      
      override protected function PopTipsNotifyCheck() : void
      {
         if(FOnCheckPopTipsModes != null)
         {
            FOnCheckPopTipsModes(this,CONST_POPTIPS.POPTIP_Goto_GeneralStar);
         }
      }
      
      protected function ProcessorWindowOnClose(param1:Object) : void
      {
         ProcessorClose();
      }
      
      protected function UIComponentsHintOnOver1(param1:Object) : void
      {
         var _loc2_:TPoint = null;
         _loc2_ = param1 as TPoint;
         this.FOverlayerGeneralStar.Context = _loc2_.Context;
         this.FOverlayerGeneralStar.Render(FUICore.MouseCoordinate);
         this.FOverlayerGeneralStar.Show();
      }
      
      protected function UIComponentsHintOnOut1(param1:Object) : void
      {
         this.FOverlayerGeneralStar.Hide();
      }
      
      private function OnPointClick(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_GeneralStar_PointReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function ProcessorsOnShortcutHyperlinks() : void
      {
         if(this.FOnShortcutHyperlinks != null)
         {
            ProcessorClose();
            this.FOnShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_Undertown);
         }
      }
      
      public function get OnActivityBigDipper() : Function
      {
         return this.FOnActivityBigDipper;
      }
      
      public function set OnActivityBigDipper(param1:Function) : void
      {
         this.FOnActivityBigDipper = param1;
      }
      
      public function get MainHeroQualityOnChange() : Function
      {
         return this.FMainHeroQualityOnChange;
      }
      
      public function set MainHeroQualityOnChange(param1:Function) : void
      {
         this.FMainHeroQualityOnChange = param1;
      }
      
      public function get AddPopTips() : Function
      {
         return this.FAddPopTips;
      }
      
      public function set AddPopTips(param1:Function) : void
      {
         this.FAddPopTips = param1;
      }
      
      public function get OnUpdateHerosBaseAttributeReq() : Function
      {
         return this.FOnUpdateHerosBaseAttributeReq;
      }
      
      public function set OnUpdateHerosBaseAttributeReq(param1:Function) : void
      {
         this.FOnUpdateHerosBaseAttributeReq = param1;
      }
      
      public function get OnEffectAcquireInventory() : Function
      {
         return this.FOnEffectAcquireInventory;
      }
      
      public function set OnEffectAcquireInventory(param1:Function) : void
      {
         this.FOnEffectAcquireInventory = param1;
      }
      
      public function get OnQueryShortcutCoordinate() : Function
      {
         return this.FOnQueryShortcutCoordinate;
      }
      
      public function set OnQueryShortcutCoordinate(param1:Function) : void
      {
         this.FOnQueryShortcutCoordinate = param1;
      }
      
      public function get ProcessorWindowEsoteric() : TProcessorWindowEsoteric
      {
         return this.FProcessorWindowEsoteric;
      }
      
      public function get OnUserTotalFightingPowerReq() : Function
      {
         return this.FOnUserTotalFightingPowerReq;
      }
      
      protected function OnTiaoZhuanClickC(param1:int) : void
      {
         if(this.FOnTiaoZhuanClick != null)
         {
            this.FOnTiaoZhuanClick(param1);
         }
      }
      
      public function get OnTiaoZhuanClick() : Function
      {
         return this.FOnTiaoZhuanClick;
      }
      
      public function set OnTiaoZhuanClick(param1:Function) : void
      {
         this.FOnTiaoZhuanClick = param1;
      }
      
      public function set OnUserTotalFightingPowerReq(param1:Function) : void
      {
         this.FOnUserTotalFightingPowerReq = param1;
      }
      
      public function get OnShortcutHyperlinks() : Function
      {
         return this.FOnShortcutHyperlinks;
      }
      
      public function set OnShortcutHyperlinks(param1:Function) : void
      {
         this.FOnShortcutHyperlinks = param1;
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowEsoteric.Load();
            return;
         }
         this.ProcessorAwakenSoulReq();
      }
      
      protected function ProcessorAwakenSoulReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_GeneralStar_AwakenSoulReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
         TutorialNextStep(702);
      }
      
      public function CheckPopTip() : void
      {
         var _loc1_:TEsotericPoint = null;
         var _loc2_:TEsotericPoint = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:TStarMap = null;
         _loc1_ = this.FEsotericPoints.GetEsotericPointByIdentifier(this.FCharacter.StarMapIndex) as TEsotericPoint;
         if(this.FCharacter.StarMapIndex == 0)
         {
            _loc1_ = this.FEsotericPoints.GetEsotericPointByIndex(0) as TEsotericPoint;
         }
         _loc2_ = this.FEsotericPoints.GetEsotericPointByIdentifier(this.FCharacter.StarMapIndex + 1) as TEsotericPoint;
         if(_loc2_ == null)
         {
            _loc3_ = _loc1_.MapNum + 1 + 17200000;
            _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_StarMap,_loc3_) as TStarMap;
            if(_loc1_ == this.FEsotericPoints.GetEsotericPointByIndex(74) || !_loc5_)
            {
               return;
            }
            _loc4_ = uint(_loc5_.StartID);
            _loc1_ = this.FEsotericPoints.GetEsotericPointByIdentifier(_loc4_) as TEsotericPoint;
         }
         else
         {
            _loc1_ = this.FEsotericPoints.GetEsotericPointByIdentifier(this.FCharacter.StarMapIndex + 1) as TEsotericPoint;
         }
         if(this.FCharacter.GeneralsSoul >= _loc1_.NeedFetch && this.FCharacter.AwakenGeneralsSoul >= _loc1_.NeedNewFetch)
         {
            if(this.FAddPopTips != null)
            {
               this.FAddPopTips(this,CONST_POPTIPS.POPTIP_UpanishadsVolumeLv);
            }
         }
      }
   }
}

