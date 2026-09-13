package Processors.Game.Lobby.WorldMap
{
   import Debugging.*;
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.*;
   import Foundation.Resources.Bins.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.Campaign.*;
   import Logics.DatebaseVO.VO.*;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.*;
   import Resources.Constants.*;
   import flash.display.*;
   import flash.events.*;
   import flash.utils.*;
   import ghostcat.util.easing.*;
   
   public class TNodalChoose extends TProcessorLobbyWindow
   {
      
      protected static const MAX_COUNT:int = 6;
      
      protected static const ELEMENT_STAMP_WIDTH:Number = -115;
      
      protected var FHelpTips:THint;
      
      protected var FScene:MovieClip;
      
      protected var FCurCityID:int;
      
      protected var FCityData:Vector.<uint>;
      
      protected var FCurIndex:int;
      
      protected var FTotleIndex:int;
      
      protected var FNodalMission:TNodalMission;
      
      protected var FBackGroundBmp:Bitmap;
      
      protected var FGotoMission:uint;
      
      protected var FTimerId:uint;
      
      protected var FCityBins:TBins;
      
      protected var FBlockPointBins:TBins;
      
      protected var FNodalModel:TNodal;
      
      protected var FIsInit:Boolean;
      
      protected var FProcessorWindowGuideHero:TProcessorWindowGuideHero;
      
      protected var FLimitLevel:int;
      
      protected var FAddPopTips:Function;
      
      protected var FOpenAutoInfo:Function;
      
      protected var FOnHelpTipsOver:Function;
      
      protected var FOnHelpTipsOut:Function;
      
      public function TNodalChoose(param1:TUIComponent, param2:TNodal)
      {
         super(param1);
         this.FHelpTips = new THint();
         this.FNodalModel = param2;
         this.FIsInit = false;
         this.FNodalMission = new TNodalMission(this,this.FNodalModel);
         this.FCityBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_City);
         this.FBlockPointBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_BlockPoint);
         this.FLimitLevel = -1;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_CAMPAIGN.RESOURCESID_Mission);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIWait() : void
      {
         if(SResourcesCore.LoadingPrimary)
         {
            return;
         }
         this.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.InitNodalChoose();
         super.ResourcesPerform_UIDispatch();
      }
      
      protected function InitNodalChoose() : void
      {
         this.FIsInit = true;
         this.FScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_CAMPAIGN.RESOURCE_ClassName_Select) as MovieClip;
         this.FScene.gotoAndStop(1);
         addChild(this.FScene);
         this.FScene.mc_ui.btn_close.addEventListener(MouseEvent.CLICK,this.OnCloseView);
         this.FScene.mc_ui.btn_help.addEventListener(MouseEvent.MOUSE_MOVE,this.ButtonHelpOnOver,false,0,true);
         this.FScene.mc_ui.btn_help.addEventListener(MouseEvent.MOUSE_OUT,this.ButtonHelpOnOut,false,0,true);
         this.FScene.mc_ui.btn_left.addEventListener(MouseEvent.CLICK,this.OnLeft);
         this.FScene.mc_ui.btn_right.addEventListener(MouseEvent.CLICK,this.OnRight);
         this.FCurIndex = MAX_COUNT - 1;
         this.FNodalMission.SetScene(this.FScene.mc_ui.mc_list);
         this.FNodalMission.OnTutorialNextStep = this.ProcessorOnTutorialNextStep;
         this.FNodalMission.OnEffectText = FOnEffectText;
         this.FNodalMission.AddPopTips = this.FAddPopTips;
         this.FNodalMission.OpenAutoInfo = this.FOpenAutoInfo;
         this.FBackGroundBmp = new Bitmap();
         this.FScene.mc_ui.mc_bg.addChild(this.FBackGroundBmp);
         this.FScene.mc_ui.mc_bg["bitmap"] = this.FBackGroundBmp;
         this.FProcessorWindowGuideHero = new TProcessorWindowGuideHero(this);
         this.Visible = true;
      }
      
      protected function ProcessorOnTutorialNextStep(param1:Object, param2:int) : void
      {
         TutorialNextStep(param2);
      }
      
      protected function OnSelectHero(param1:Object, param2:uint, param3:uint) : void
      {
         this.EnterHurdleRequest(param2,param3);
      }
      
      protected function ReadyEnterHurdle(param1:uint) : void
      {
         var _loc2_:TConfigValue = null;
         if(this.FLimitLevel < 0)
         {
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.GuideHero_Level_limit) as TConfigValue;
            this.FLimitLevel = _loc2_.Value as uint;
         }
         if(SLogicsCore.Character.GetMainHeroLogicLevel(SLogicsCore.Character.GetMainLevel()) < this.FLimitLevel)
         {
            this.FProcessorWindowGuideHero.MissionId = param1;
            this.FProcessorWindowGuideHero.Visible = true;
         }
         else
         {
            this.EnterHurdleRequest(param1,0);
         }
      }
      
      protected function EnterHurdleRequest(param1:uint, param2:uint) : void
      {
         var _loc3_:TPacket = null;
         var _loc4_:ByteArray = null;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Enter_Hurdle);
         _loc4_ = _loc3_.Data;
         _loc4_.writeInt(this.FCurCityID);
         _loc4_.writeInt(param1);
         _loc4_.writeInt(param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
         if(param1 == this.FNodalModel.CurMissionID)
         {
            TutorialNextStep(300);
         }
      }
      
      protected function CheckBtn() : void
      {
         if(this.FScene)
         {
            this.FScene.mc_ui.btn_left.visible = Boolean(this.FCurIndex >= MAX_COUNT);
            this.FScene.mc_ui.btn_right.visible = Boolean(this.FCurIndex < this.FTotleIndex);
         }
      }
      
      protected function GetCityMission(param1:int) : Vector.<uint>
      {
         var _loc2_:TCity = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Vector.<uint> = null;
         _loc2_ = this.FCityBins.GetDatebaseByIdentifier(this.FCurCityID) as TCity;
         _loc3_ = _loc2_.Start;
         _loc4_ = _loc2_.Last;
         _loc6_ = new Vector.<uint>();
         _loc5_ = _loc3_;
         while(_loc5_ <= _loc4_)
         {
            _loc6_.push(_loc5_);
            _loc5_++;
         }
         return _loc6_;
      }
      
      protected function Updata() : void
      {
         TweenUtil.removeTween(this.FNodalMission,false);
         if(this.FCurIndex < MAX_COUNT)
         {
            TweenUtil.to(this.FNodalMission,700,{
               "x":0,
               "ease":Expo.easeOut
            });
         }
         else
         {
            TweenUtil.to(this.FNodalMission,700,{
               "x":(this.FCurIndex - MAX_COUNT + 1) * ELEMENT_STAMP_WIDTH,
               "ease":Expo.easeOut
            });
         }
      }
      
      protected function OnLeft(param1:MouseEvent = null) : void
      {
         clearTimeout(this.FTimerId);
         this.FCurIndex -= MAX_COUNT;
         if(this.FCurIndex < MAX_COUNT - 1)
         {
            this.FCurIndex = MAX_COUNT - 1;
         }
         this.Updata();
         this.CheckBtn();
      }
      
      protected function OnRight(param1:MouseEvent = null) : void
      {
         clearTimeout(this.FTimerId);
         this.FCurIndex += MAX_COUNT;
         if(this.FCurIndex > this.FTotleIndex)
         {
            this.FCurIndex = this.FTotleIndex;
         }
         this.Updata();
         this.CheckBtn();
      }
      
      protected function OnCloseView(param1:MouseEvent) : void
      {
         this.Visible = false;
      }
      
      protected function ButtonHelpOnOver(param1:MouseEvent) : void
      {
         var _loc2_:TSystemLanguage = null;
         if(this.FOnHelpTipsOver != null)
         {
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.HELPTIPS_Nodal) as TSystemLanguage;
            this.FHelpTips.Content = _loc2_.Desc;
            this.FOnHelpTipsOver(this,this.FHelpTips);
         }
      }
      
      protected function ButtonHelpOnOut(param1:MouseEvent) : void
      {
         if(this.FOnHelpTipsOut != null)
         {
            this.FOnHelpTipsOut(this);
         }
      }
      
      protected function GotoPageIndex() : void
      {
         clearTimeout(this.FTimerId);
         this.FCurIndex = Math.max(this.FCityData.indexOf(this.FGotoMission),MAX_COUNT - 1);
         this.Updata();
         this.CheckBtn();
      }
      
      override public function set OnEffectText(param1:Function) : void
      {
         FOnEffectText = param1;
      }
      
      public function get OnHelpTipsOver() : Function
      {
         return this.FOnHelpTipsOver;
      }
      
      public function set OnHelpTipsOver(param1:Function) : void
      {
         this.FOnHelpTipsOver = param1;
      }
      
      public function get OnHelpTipsOut() : Function
      {
         return this.FOnHelpTipsOut;
      }
      
      public function set OnHelpTipsOut(param1:Function) : void
      {
         this.FOnHelpTipsOut = param1;
      }
      
      public function get AddPopTips() : Function
      {
         return this.FAddPopTips;
      }
      
      public function set AddPopTips(param1:Function) : void
      {
         this.FAddPopTips = param1;
      }
      
      public function get OpenAutoInfo() : Function
      {
         return this.FOpenAutoInfo;
      }
      
      public function set OpenAutoInfo(param1:Function) : void
      {
         this.FOpenAutoInfo = param1;
      }
      
      override public function set Visible(param1:Boolean) : void
      {
         if(this.FScene == null)
         {
            return;
         }
         if(param1)
         {
            this.FScene.visible = param1;
            this.FScene.gotoAndPlay("come");
         }
         else
         {
            this.FScene.gotoAndPlay("out");
         }
      }
      
      public function HideScene() : void
      {
         if(this.FScene == null)
         {
            return;
         }
         this.FScene.visible = false;
      }
      
      public function UpdataBitmap() : void
      {
         var _loc1_:TBlockPoint = null;
         if(this.FCurCityID == 0)
         {
            return;
         }
         _loc1_ = this.FBlockPointBins.GetDatebaseByIdentifier(this.FCityData[0]) as TBlockPoint;
         TGameUtil.ShowImageByID(TGameUtil.Type_BackgroundIcon,this.FBackGroundBmp,CONST_MODULES.MODULE_WorldMap,_loc1_.TollgatIcon);
         if(this.FNodalMission != null)
         {
            this.FNodalMission.UpdataBitmap();
         }
      }
      
      public function SetCityID(param1:int, param2:int, param3:int = -1) : void
      {
         if(!this.FIsInit)
         {
            Load();
         }
         this.FCurCityID = param1;
         this.FCityData = this.GetCityMission(this.FCurCityID);
         this.FTotleIndex = this.FCityData.length - 1;
         this.FCurIndex = MAX_COUNT - 1;
         if(this.FCityData.length <= 0)
         {
            return;
         }
         if(this.FScene)
         {
            this.FScene.mc_ui.mc_left_falling.play();
            this.FScene.mc_ui.mc_right_falling.play();
         }
         this.FGotoMission = param3;
         if(param3 > 0)
         {
            if(this.FGotoMission > param2)
            {
               this.FGotoMission = param2;
            }
            if(this.FCityData.indexOf(this.FGotoMission) < 0)
            {
               this.FGotoMission = this.FCityData[this.FCityData.length - 1];
            }
         }
         else
         {
            this.FCurIndex = param2;
            this.FGotoMission = param2;
         }
         this.FTimerId = setTimeout(this.GotoPageIndex,300);
         this.FNodalMission.SetMissionID(this.FCurCityID,param2,this.FCityData,this.FGotoMission);
         this.FNodalMission.x = 0;
         this.Updata();
         this.CheckBtn();
      }
   }
}

