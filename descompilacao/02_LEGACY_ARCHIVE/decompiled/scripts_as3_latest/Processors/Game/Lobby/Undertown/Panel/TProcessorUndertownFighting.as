package Processors.Game.Lobby.Undertown.Panel
{
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.Common.THint;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.Characters.THero;
   import Logics.DatebaseVO.VO.Json.TDailyTaskReward;
   import Logics.DatebaseVO.VO.TArticle;
   import Logics.DatebaseVO.VO.TDungeonsBattle;
   import Logics.DatebaseVO.VO.TDungeonsBattleConfig;
   import Logics.DatebaseVO.VO.TRoleModel;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Undertown.TUndertownLogicData;
   import Logics.Undertown.TUndertownPracticeListData;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Components.TUIHero;
   import Processors.Game.Lobby.TongLing.ToolS.Tools_Help;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrameCopy;
   import Processors.Game.Lobby.Undertown.LittlePanel.*;
   import Rendering.Overlayers.FeteBlood.TGoldCallBtn;
   import Rendering.Overlayers.Hints.TOverlayerHint;
   import Rendering.Overlayers.Inventories.TOverlayerAccessory;
   import Rendering.Overlayers.Inventories.TOverlayerAppliance;
   import Rendering.Overlayers.Inventories.TOverlayerEquipment;
   import Rendering.Overlayers.Inventories.TOverlayerTreasure;
   import Rendering.Overlayers.TOverlayer;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_INVENTORY;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_UNDERTOWN;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class TProcessorUndertownFighting extends TProcessorLobbyWindow
   {
      
      public static const CATEGORY_Normal:uint = CONST_INVENTORY.CATEGORY_Normal;
      
      public static const CATEGORY_Equipment:uint = CONST_INVENTORY.CATEGORY_Equipment;
      
      public static const CATEGORY_Gem:uint = CONST_INVENTORY.CATEGORY_Gem;
      
      public static const CATEGORY_Treasure:uint = CONST_INVENTORY.CATEGORY_Treasure;
      
      public static const CATEGORY_Material:uint = CONST_INVENTORY.CATEGORY_Material;
      
      public static const CATEGORY_Accessories:uint = CONST_INVENTORY.CATEGORY_Accessories;
      
      protected var FMainUI:Sprite;
      
      protected var FOverlayerEquipment:TOverlayerEquipment;
      
      protected var FOverlayerAccessory:TOverlayerAccessory;
      
      protected var FOverlayerTreasure:TOverlayerTreasure;
      
      protected var FOverlayerAppliance:TOverlayerAppliance;
      
      protected var FOverlayerHint:TOverlayerHint;
      
      protected var FTGoldCallBtn:TGoldCallBtn = null;
      
      protected var FLittleOnePanel:LittleOnePanel;
      
      protected var FLittleTwoPanel:LittleTwoPanel;
      
      protected var FLittleThreePanel:LittleThreePanel;
      
      protected var FUIHero:TUIHero;
      
      protected var FUndertownFighting:MovieClip = null;
      
      protected var FMC_MainHeroIcon:MovieClip = null;
      
      protected var FMC_HeroPosition:MovieClip = null;
      
      protected var FTF_XiuLianCengshu:TextField;
      
      protected var FTF_YiXiuLianShiJian:TextField;
      
      protected var FTF_ShengYuXiuLianShiJian:TextField;
      
      protected var FTF_YiHuoDeXiuLianJiangLi:TextField;
      
      protected var FMC_TiaoZhanJiLuBtn:MovieClip;
      
      protected var FMC_ChaKanXiuLianLieLieBiaoBtn:MovieClip;
      
      protected var FMC_OverPractice:MovieClip;
      
      protected var FBtn_Close:SimpleButton;
      
      protected var FCurColdTime:uint;
      
      protected var FCurMaxTime:uint;
      
      protected var FCueCurFream:int;
      
      protected var FCharacter:TCharacter;
      
      protected var ThiNT:THint;
      
      protected var FUndertownLogicData:TUndertownLogicData;
      
      protected var FGetRewardFunction:Function;
      
      protected var FC_S_SaoDang:Function;
      
      protected var FTiaoZhanBackFunction:Function;
      
      protected var FC_S_GetPaiMing:Function;
      
      protected var FBackFunctionForTiaoZhanLog:Function;
      
      protected var FBackFunctionForSeePracticeLise:Function;
      
      protected var FBackFunctionForOverPractice:Function;
      
      protected var FCAO:Function;
      
      public function TProcessorUndertownFighting(param1:TUIComponent)
      {
         super(param1);
         this.FLittleOnePanel = new LittleOnePanel(param1);
         this.FLittleOnePanel.FightingCellBackFunction = this.FightingCellBackFunction;
         this.FLittleOnePanel.UIHintOnOver = this.UIComponentsHintOnOver;
         this.FLittleOnePanel.UIHintOnOut = this.UIComponentsHintOnOut;
         this.FLittleOnePanel.C_S_SaoDang = this.C_S_SaoDangC;
         this.FLittleTwoPanel = new LittleTwoPanel(param1);
         this.FLittleTwoPanel.BackBtnFunction = this.BackBtnFunction;
         this.FLittleTwoPanel.ChallengeBtnBackFunction = this.ChallengeBtnBackFunction;
         this.FLittleThreePanel = new LittleThreePanel(param1);
         this.FLittleThreePanel.SlotsOnOutBackFunction = this.SlotsOnOut;
         this.FLittleThreePanel.SlotsOnOverBackFunction = this.SlotsOnOver;
         this.FLittleThreePanel.SlotsOnQuerySequenceContextBackFunction = this.SlotsOnQuerySequenceContext;
         this.FLittleThreePanel.MC_GoIn_FightingFunction = this.FTiaoZhanBackFunctionC;
         this.FLittleThreePanel.MC_Back_BtnFunction = this.MC_Back_BtnFunction;
         this.FLittleThreePanel.GetRewardFunction = this.C_S_GetReward;
         this.FLittleThreePanel.NimeiMove = this.O_V_F;
         this.FLittleThreePanel.NimeiOver = this.O_U_F;
         this.FOverlayerEquipment = new TOverlayerEquipment(this.Parent,CONST_MODULES.MODULE_Undertown);
         this.FOverlayerEquipment.Visible = false;
         this.FOverlayerAccessory = new TOverlayerAccessory(this.Parent,CONST_MODULES.MODULE_Undertown);
         this.FOverlayerAccessory.Visible = false;
         this.FOverlayerTreasure = new TOverlayerTreasure(this.Parent,CONST_MODULES.MODULE_Undertown);
         this.FOverlayerTreasure.Visible = false;
         this.FOverlayerAppliance = new TOverlayerAppliance(this.Parent,CONST_MODULES.MODULE_Undertown);
         this.FOverlayerAppliance.Visible = false;
         this.FOverlayerHint = new TOverlayerHint(this.Parent);
         this.FOverlayerHint.Visible = false;
         this.FTGoldCallBtn = new TGoldCallBtn(this.Parent);
         this.FTGoldCallBtn.Visible = false;
         this.ThiNT = new THint();
         this.FCharacter = SLogicsCore.Character;
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         this.FUndertownLogicData = SLogicsCore.UndertownLogicData;
         this.FMainUI = TUtilityReflection.CreateDisplayObjectInstance("MC_UndertownFighting") as Sprite;
         this.FMainUI.x = (FUICore.StageWidth - this.FMainUI.width) / 2;
         this.FMainUI.y = (FUICore.StageHeight - this.FMainUI.height) / 2;
         addChild(this.FMainUI);
         this.FUndertownFighting = this.FMainUI["UndertownFighting"];
         this.FMC_MainHeroIcon = this.FUndertownFighting["MC_MainHeroIcon"];
         this.FMC_HeroPosition = this.FMC_MainHeroIcon["MC_HeroIcon"];
         this.FTF_XiuLianCengshu = this.FUndertownFighting["TF_XiuLianCengshu"];
         this.FTF_YiXiuLianShiJian = this.FUndertownFighting["TF_YiXiuLianShiJian"];
         this.FTF_ShengYuXiuLianShiJian = this.FUndertownFighting["TF_ShengYuXiuLianShiJian"];
         this.FTF_YiHuoDeXiuLianJiangLi = this.FUndertownFighting["TF_YiHuoDeXiuLianJiangLi"];
         this.FMC_TiaoZhanJiLuBtn = this.FUndertownFighting["MC_TiaoZhanJiLuBtn"];
         this.FMC_ChaKanXiuLianLieLieBiaoBtn = this.FUndertownFighting["MC_ChaKanXiuLianLieLieBiaoBtn"];
         this.FMC_OverPractice = this.FUndertownFighting["MC_OverPractice"];
         this.FBtn_Close = this.FMainUI["Btn_Close"];
         this.FUndertownFighting.gotoAndStop(1);
         _loc3_ = this.FUndertownFighting["MC_OneUndertown"];
         this.FLittleOnePanel.LogicData = this.FUndertownLogicData;
         this.FLittleOnePanel.TempPanel = _loc3_;
         this.FUndertownFighting.addChild(this.FLittleOnePanel);
         this.FUndertownFighting.gotoAndStop(2);
         _loc3_ = this.FUndertownFighting["MC_TwoUndertown"];
         this.FLittleTwoPanel.LogicData = this.FUndertownLogicData;
         this.FLittleTwoPanel.TempPanel = _loc3_;
         this.FUndertownFighting.addChild(this.FLittleTwoPanel);
         this.FUndertownFighting.gotoAndStop(3);
         _loc3_ = this.FUndertownFighting["MC_ThreeUndertown"];
         this.FLittleThreePanel.LogicData = this.FUndertownLogicData;
         this.FLittleThreePanel.TempPanel = _loc3_;
         this.FUndertownFighting.addChild(this.FLittleThreePanel);
         this.FUIHero = new TUIHero(Parent);
         this.FMC_HeroPosition.addChild(this.FUIHero);
         this.FUIHero.OnQuerySequenceContext = this.HeroOnQuerySequenceContext;
         this.FUIHero.DefaultRole = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_DefaultRoleTexture) as Sprite;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerEquipment);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerTreasure);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerAppliance);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerAccessory);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerHint);
         TUtilityUIOverlayer.ResourcesDispatch(this.FTGoldCallBtn);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         TGameUtil.setButtonMode(this.FMC_TiaoZhanJiLuBtn,true);
         TGameUtil.setButtonMode(this.FMC_ChaKanXiuLianLieLieBiaoBtn,true);
         this.FMC_TiaoZhanJiLuBtn.addEventListener(MouseEvent.CLICK,this.BtnClick);
         this.FMC_ChaKanXiuLianLieLieBiaoBtn.addEventListener(MouseEvent.CLICK,this.BtnClick);
         this.FMC_OverPractice.addEventListener(MouseEvent.CLICK,this.BtnClick);
         this.FBtn_Close.addEventListener(MouseEvent.CLICK,this.BtnClick);
         new Tools_Help(this,this.FMainUI["Btn_Help"],CONST_SYSTEMLANGUAGE.HELPTIPS_70170107,FUICore);
         new Tools_Help(this,this.FMainUI["MC_AwakenSoul"],CONST_SYSTEMLANGUAGE.HELPTIPS_70170105,FUICore);
         this.FUIHero.Context = this.FCharacter.MainHero;
         super.ResourcesPerform_UILocations();
      }
      
      public function set CAO(param1:Function) : void
      {
         this.FCAO = param1;
      }
      
      protected function BtnClick(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FMC_TiaoZhanJiLuBtn:
               if(this.FBackFunctionForTiaoZhanLog != null)
               {
                  this.FBackFunctionForTiaoZhanLog();
               }
               break;
            case this.FBtn_Close:
               if(this.FCAO != null)
               {
                  this.CueCurFream = 0;
                  this.FCAO();
               }
               break;
            case this.FMC_ChaKanXiuLianLieLieBiaoBtn:
               if(this.FBackFunctionForSeePracticeLise != null)
               {
                  this.FBackFunctionForSeePracticeLise();
               }
               break;
            case this.FMC_OverPractice:
               if(!this.FMC_OverPractice.buttonMode)
               {
                  return;
               }
               if(this.FBackFunctionForOverPractice != null)
               {
                  this.FBackFunctionForOverPractice();
               }
         }
      }
      
      override protected function LogicsPerform() : void
      {
         if(!Visible)
         {
            return;
         }
         this.FLittleOnePanel.LogicsPerform();
         this.FLittleTwoPanel.LogicsPerform();
         this.FLittleThreePanel.LogicsPerform();
         this.FUIHero.Update();
         this.UpdateColeTime();
         super.LogicsPerform();
      }
      
      public function OpenThisPanel() : void
      {
         this.UpdateMainRoleInformation();
         this.VisibelByFream();
      }
      
      public function UpdateMainRoleInformation() : void
      {
         var _loc1_:TUndertownPracticeListData = null;
         _loc1_ = this.FUndertownLogicData.GetTUndertownPracticeListDataById64(this.FCharacter.Identifier0,this.FCharacter.Identifier1);
         this.FMainUI["MC_AwakenSoul"].TF_Point.text = SLogicsCore.Character.AwakenGeneralsSoul.toString();
         if(!_loc1_)
         {
            this.FTF_XiuLianCengshu.text = "";
            this.FTF_YiXiuLianShiJian.text = "";
            this.FTF_ShengYuXiuLianShiJian.text = "";
            this.FTF_YiHuoDeXiuLianJiangLi.text = "";
            this.FCurColdTime = 0;
            TGameUtil.setButtonMode(this.FMC_OverPractice,false);
         }
         else
         {
            this.FTF_XiuLianCengshu.text = _loc1_.DungeonsPractiseData.CampaignName;
            this.FCurColdTime = _loc1_.PracticeEndTime;
            this.FCurMaxTime = _loc1_.TimeLimit;
            TGameUtil.setButtonMode(this.FMC_OverPractice,true);
         }
      }
      
      protected function UpdateColeTime() : void
      {
         var _loc1_:uint = 0;
         if(!this.FCurColdTime)
         {
            return;
         }
         _loc1_ = this.FCurColdTime - STimingCore.GetServerTick();
         this.FTF_ShengYuXiuLianShiJian.text = TGameUtil.fomatTime(_loc1_);
         _loc1_ = this.FCurMaxTime - _loc1_;
         this.FTF_YiXiuLianShiJian.text = TGameUtil.fomatTime(_loc1_);
      }
      
      public function set CueCurFream(param1:int) : void
      {
         this.FCueCurFream = param1;
      }
      
      public function VisibelByFream() : void
      {
         this.FLittleOnePanel.visible = false;
         this.FLittleTwoPanel.visible = false;
         this.FLittleThreePanel.visible = false;
         switch(this.FCueCurFream)
         {
            case 0:
               this.FLittleOnePanel.visible = true;
               this.FLittleOnePanel.UpdateView();
               break;
            case 1:
               this.FLittleTwoPanel.visible = true;
               this.FLittleTwoPanel.UpdateView();
               break;
            case 2:
               this.FLittleThreePanel.visible = true;
               this.FLittleThreePanel.UpdateView();
         }
      }
      
      public function SaoDangBack(param1:ByteArray) : void
      {
         this.FLittleOnePanel.StartTimer(param1);
      }
      
      protected function O_U_F() : void
      {
         if(this.FTGoldCallBtn != null)
         {
            this.FTGoldCallBtn.Hide();
         }
      }
      
      protected function O_V_F(param1:TDungeonsBattle) : void
      {
         var _loc2_:Vector.<TDailyTaskReward> = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:TArticle = null;
         var _loc6_:TBins = null;
         if(this.FTGoldCallBtn != null)
         {
            _loc2_ = param1.FirstOccupationAwardVect;
            _loc4_ = "";
            if(_loc2_.length <= 0)
            {
               return;
            }
            _loc6_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               _loc5_ = _loc6_.GetDatebaseByIdentifier(CONST_COMMON.GetItemIDByType(_loc2_[_loc3_].Type,_loc2_[_loc3_].Code,_loc6_)) as TArticle;
               _loc4_ += TUtilityString.Format(new ConsumeFrameCopy(STRING_UNDERTOWN.STRING_UNDERTOWN_16).DescribeString,CONST_COMMON.QUALITYCOLOR_INDEX_1[_loc5_.Quality],_loc5_.Name,_loc2_[_loc3_].Amount);
               _loc3_++;
            }
            this.ThiNT.Content = TUtilityString.Format(new ConsumeFrameCopy(STRING_UNDERTOWN.STRING_UNDERTOWN_15).DescribeString,_loc4_);
            this.FTGoldCallBtn.Context = this.ThiNT;
            this.FTGoldCallBtn.Render(FUICore.MouseCoordinate);
            this.FTGoldCallBtn.Show();
         }
      }
      
      protected function C_S_GetReward(param1:uint) : void
      {
         if(this.FGetRewardFunction != null)
         {
            this.FGetRewardFunction(param1);
         }
      }
      
      protected function C_S_SaoDangC() : void
      {
         if(this.FC_S_SaoDang != null)
         {
            this.FC_S_SaoDang();
         }
      }
      
      protected function FTiaoZhanBackFunctionC() : void
      {
         if(this.FTiaoZhanBackFunction != null)
         {
            this.FTiaoZhanBackFunction();
         }
      }
      
      public function set GetRewardFunction(param1:Function) : void
      {
         this.FGetRewardFunction = param1;
      }
      
      public function set C_S_SaoDang(param1:Function) : void
      {
         this.FC_S_SaoDang = param1;
      }
      
      public function set TiaoZhanBackFunction(param1:Function) : void
      {
         this.FTiaoZhanBackFunction = param1;
      }
      
      protected function MC_Back_BtnFunction() : void
      {
         this.FCueCurFream = 1;
         this.VisibelByFream();
      }
      
      protected function FightingCellBackFunction(param1:TDungeonsBattleConfig) : void
      {
         if(this.FUndertownLogicData.IsAtDaoJiShiIng)
         {
            return;
         }
         this.FLittleTwoPanel.StartCustomsData = param1;
         this.FCueCurFream = 1;
         this.VisibelByFream();
      }
      
      protected function BackBtnFunction() : void
      {
         this.FCueCurFream = 0;
         this.VisibelByFream();
      }
      
      public function ChallengeBtnBackFunction() : void
      {
         this.FLittleThreePanel.ThisData = this.FUndertownLogicData.CurCustomsData;
         this.FCueCurFream = 2;
         this.VisibelByFream();
         if(this.FC_S_GetPaiMing != null)
         {
            this.FC_S_GetPaiMing(this.FUndertownLogicData.CurCustomsData);
         }
      }
      
      public function set BackFunctionForOverPractice(param1:Function) : void
      {
         this.FBackFunctionForOverPractice = param1;
      }
      
      public function set BackFunctionForSeePracticeLise(param1:Function) : void
      {
         this.FBackFunctionForSeePracticeLise = param1;
      }
      
      public function set BackFunctionForTiaoZhanLog(param1:Function) : void
      {
         this.FBackFunctionForTiaoZhanLog = param1;
      }
      
      public function S_C_GetPaiMing(param1:ByteArray) : void
      {
         this.FLittleThreePanel.S_C_GetPaiMing(param1);
      }
      
      public function set C_S_GetPaiMing(param1:Function) : void
      {
         this.FC_S_GetPaiMing = param1;
      }
      
      public function set MC_ResetBtnClickBack(param1:Function) : void
      {
         this.FLittleOnePanel.MC_ResetBtnClickBack = param1;
      }
      
      public function set MopUpBtnClickBack(param1:Function) : void
      {
         this.FLittleOnePanel.MopUpBtnClickBack = param1;
      }
      
      public function SaoDangLog(param1:ByteArray) : void
      {
         this.FLittleOnePanel.UpdateScrollBar_1(param1);
      }
      
      public function SuiJiReward(param1:ByteArray) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TArticle = null;
         var _loc6_:int = 0;
         var _loc2_:uint = param1.readUnsignedInt();
         _loc3_ = param1.readShort();
         var _loc7_:String = "";
         var _loc8_:TBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc6_ = param1.readShort();
            _loc2_ = param1.readUnsignedInt();
            _loc2_ = CONST_COMMON.GetItemIDByType(_loc6_,_loc2_,_loc8_);
            _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,_loc2_) as TArticle;
            _loc2_ = param1.readUnsignedInt();
            _loc7_ += _loc5_.Name + " *" + _loc2_;
            _loc4_++;
         }
         if(!this.FTF_YiHuoDeXiuLianJiangLi)
         {
            return;
         }
         this.FTF_YiHuoDeXiuLianJiangLi.text = _loc7_;
      }
      
      protected function UIComponentsHintOnOut(param1:Object) : void
      {
         this.FOverlayerHint.Hide();
      }
      
      protected function UIComponentsHintOnOver(param1:Object, param2:THint) : void
      {
         this.FOverlayerHint.Context = param2;
         this.FOverlayerHint.Render(FUICore.MouseCoordinate);
         this.FOverlayerHint.Show();
      }
      
      protected function SlotsOnOver(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = null;
         var _loc4_:TOverlayer = null;
         _loc3_ = param2 as TInventory;
         switch(_loc3_.Category)
         {
            case CATEGORY_Equipment:
               _loc4_ = this.FOverlayerEquipment;
               break;
            case CATEGORY_Treasure:
               _loc4_ = this.FOverlayerTreasure;
               break;
            case CATEGORY_Accessories:
               _loc4_ = this.FOverlayerAccessory;
               break;
            default:
               _loc4_ = this.FOverlayerAppliance;
         }
         if(_loc4_ != null)
         {
            _loc4_.Context = _loc3_;
            _loc4_.Render(FUICore.MouseCoordinate);
            _loc4_.Show();
         }
      }
      
      protected function SlotsOnOut(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = null;
         var _loc4_:TOverlayer = null;
         _loc3_ = param2 as TInventory;
         switch(_loc3_.Category)
         {
            case CATEGORY_Equipment:
               _loc4_ = this.FOverlayerEquipment;
               break;
            case CATEGORY_Treasure:
               _loc4_ = this.FOverlayerTreasure;
               break;
            case CATEGORY_Accessories:
               _loc4_ = this.FOverlayerAccessory;
               break;
            default:
               _loc4_ = this.FOverlayerAppliance;
         }
         if(_loc4_ != null)
         {
            _loc4_.Hide();
         }
      }
      
      protected function SlotsOnQuerySequenceContext(param1:Object, param2:TQueryAnimationSequence, param3:uint = 0) : void
      {
         var _loc4_:TInventory = null;
         var _loc5_:TResourceRepositoryTexture = null;
         var _loc6_:TTexture = null;
         _loc4_ = param1 as TInventory;
         _loc5_ = SResourcesCore.TexturesInventory;
         _loc6_ = _loc5_.GetTextureByIdentifier(_loc4_.IDTexture);
         if(_loc6_ != null)
         {
            param2.Value = _loc6_.GetAnimationSequenceByIdentifier(param3);
         }
         else
         {
            _loc5_.LoadSecondary(_loc4_.IDTexture,CONST_MODULES.MODULE_Undertown);
         }
      }
      
      protected function HeroOnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint = 0) : void
      {
         var _loc5_:THero = null;
         var _loc6_:TResourceRepositoryTexture = null;
         var _loc7_:TTexture = null;
         var _loc8_:TBounds = null;
         var _loc9_:TCoordinate = null;
         var _loc10_:TRoleModel = null;
         _loc5_ = param2 as THero;
         _loc8_ = new TBounds();
         _loc9_ = new TCoordinate();
         _loc6_ = SResourcesCore.TexturesModel;
         _loc10_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_RoleModel,_loc5_.Identifier) as TRoleModel;
         _loc7_ = _loc6_.GetTextureByIdentifier(_loc10_.Model);
         if(_loc7_ != null)
         {
            param3.Value = _loc7_.GetAnimationSequenceByIndex(0);
            param3.Value.Evaluate(_loc9_,_loc8_);
            this.FUIHero.X = _loc8_.X;
            this.FUIHero.Y = _loc8_.Y;
         }
         else
         {
            _loc6_.LoadSecondary(_loc10_.Model,CONST_MODULES.MODULE_Heros);
            this.FUIHero.X = 0;
            this.FUIHero.Y = 0;
         }
      }
   }
}

