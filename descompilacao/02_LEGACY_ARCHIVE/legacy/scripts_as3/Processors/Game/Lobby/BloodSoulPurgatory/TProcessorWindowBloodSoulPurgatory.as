package Processors.Game.Lobby.BloodSoulPurgatory
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.DatebaseVO.VO.TBloodSoul_battle;
   import Logics.Inventories.TInventories;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Common.Effects.Texts.TEffectCoordinateParameters;
   import Processors.Game.Common.Effects.Texts.TEffectTextParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Resources.Constants.CONST_BLOODPURGATORY;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   public class TProcessorWindowBloodSoulPurgatory extends TProcessorLobbyWindow
   {
      
      protected var FMcPanel:Sprite;
      
      protected var FMcPanelBiood:Sprite;
      
      protected var FMcPanelPurgatory:Sprite;
      
      protected var ProcessorBloodPurgatory:TProcessorBloodPurgatory;
      
      protected var ProcessorBloodSoul:TProcessorBloodSoul;
      
      protected var ProcessorBloodSoulPurgatory:TProcessorBloodSoulPurgatory;
      
      protected var UnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FSelectInventories:TInventories;
      
      protected var FTempSelectInventoriesId:Vector.<uint>;
      
      protected var FTempSelectInventoriesNum:Vector.<uint>;
      
      protected var FIsExcel:int;
      
      protected var FBloodSoulBtnFun:Function;
      
      protected var FShortcutGetStuffBtnFun:Function;
      
      protected var FBloodSoulChangeBtnFun:Function;
      
      protected var FBloodSoulCloseBtnFun:Function;
      
      protected var FCustomsTabFun:Function;
      
      protected var FAlonePopFrameFun:Function;
      
      protected var FCBloodSoulBtnFun:Function;
      
      protected var FChallengeBtnFun:Function;
      
      protected var FBtnOverBackFunc:Function;
      
      protected var FBtnMoveBackFunc:Function;
      
      protected var FBtnOutBackFunc:Function;
      
      protected var FGoToBloodPurgatoryPanel:Function;
      
      protected var FUIComponentsHintOnOver:Function;
      
      protected var FUIComponentsHintOnOut:Function;
      
      protected var FUIComponentsLittleOnOver:Function;
      
      protected var FUIComponentsLittleOnOut:Function;
      
      protected var FDistant:Function;
      
      public function TProcessorWindowBloodSoulPurgatory(param1:TUIComponent)
      {
         super(param1);
         this.ProcessorBloodPurgatory = new TProcessorBloodPurgatory(param1);
         this.ProcessorBloodPurgatory.BloodSoulCloseBtnFun = this.BloodSoulCloseBtnFunF;
         this.ProcessorBloodPurgatory.CBloodSoulBtnFun = this.CBloodSoulBtnFunF;
         this.ProcessorBloodPurgatory.ChallengeBtnFun = this.ChallengeBtnFunF;
         this.ProcessorBloodPurgatory.UIComponentsHintOnOver = this.FUIComponentsHintOnOverF;
         this.ProcessorBloodPurgatory.UIComponentsHintOnOut = this.FUIComponentsHintOnOutF;
         this.ProcessorBloodPurgatory.UIComponentsLittleOnOver = this.FUIComponentsLittleOnOverF;
         this.ProcessorBloodPurgatory.UIComponentsLittleOnOut = this.FUIComponentsLittleOnOutF;
         this.ProcessorBloodSoul = new TProcessorBloodSoul(param1);
         this.ProcessorBloodSoul.BloodSoulCloseBtnFun = this.BloodSoulCloseBtnFunF;
         this.ProcessorBloodSoul.AlonePopBackFunc = this.FAlonePopFrameF;
         this.ProcessorBloodSoul.BtnOverBackFunc = this.FBtnOverBackFuncF;
         this.ProcessorBloodSoul.BtnMoveBackFunc = this.FBtnMoveBackFuncF;
         this.ProcessorBloodSoul.BtnOutBackFunc = this.FBtnOutBackFuncF;
         this.ProcessorBloodSoul.Distant = this.FDistantF;
         this.ProcessorBloodSoul.OnEffectText = this.ForEffect;
         this.ProcessorBloodSoul.GoToBloodPurgatoryPanel = this.GoToBloodPurgatoryPanelF;
         this.ProcessorBloodSoulPurgatory = new TProcessorBloodSoulPurgatory(param1);
         this.ProcessorBloodSoulPurgatory.BloodSoulBtnFun = this.BloodSoulBtnFunF;
         this.ProcessorBloodSoulPurgatory.ShortcutGetStuffBtnFun = this.ShortcutGetStuffBtnFunF;
         this.ProcessorBloodSoulPurgatory.BloodSoulChangeBtnFun = this.BloodSoulChangeBtnFunF;
         this.ProcessorBloodSoulPurgatory.CustomsTabFun = this.CustomsTabFunF;
         this.ProcessorBloodSoulPurgatory.OnEffectText = this.ForEffect;
         this.UnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FSelectInventories = new TInventories();
         this.FTempSelectInventoriesId = new Vector.<uint>();
         this.FTempSelectInventoriesNum = new Vector.<uint>();
      }
      
      public function ForEffect(param1:Object, param2:String, param3:TEffectTextParameters = null, param4:TEffectCoordinateParameters = null) : void
      {
         EffectGenerateText(param2);
      }
      
      public function FDistantF(param1:Vector.<DataStructureForBloodSoul>) : void
      {
         if(this.FDistant != null)
         {
            this.FDistant(param1);
         }
      }
      
      public function FUIComponentsHintOnOverF() : void
      {
         if(this.FUIComponentsHintOnOver != null)
         {
            this.FUIComponentsHintOnOver(this.FSelectInventories.GetInventoryByIndex(0),this.FTempSelectInventoriesNum[0]);
         }
      }
      
      public function FUIComponentsHintOnOutF() : void
      {
         if(this.FUIComponentsHintOnOut != null)
         {
            this.FUIComponentsHintOnOut(this.FSelectInventories.GetInventoryByIndex(0),this.FTempSelectInventoriesNum[0]);
         }
      }
      
      public function FUIComponentsLittleOnOverF() : void
      {
         if(this.FUIComponentsLittleOnOver != null)
         {
            if(this.FSelectInventories.Count == 1)
            {
               this.FUIComponentsLittleOnOver(null,0);
            }
            else
            {
               this.FUIComponentsLittleOnOver(this.FSelectInventories.GetInventoryByIndex(1),this.FTempSelectInventoriesNum[1]);
            }
         }
      }
      
      public function FUIComponentsLittleOnOutF() : void
      {
         if(this.FUIComponentsLittleOnOut != null)
         {
            if(this.FSelectInventories.Count == 1)
            {
               this.FUIComponentsLittleOnOut(null,0);
            }
            else
            {
               this.FUIComponentsLittleOnOut(this.FSelectInventories.GetInventoryByIndex(1),this.FTempSelectInventoriesNum[1]);
            }
         }
      }
      
      public function SetIsWin(param1:Boolean) : void
      {
         this.ProcessorBloodPurgatory.SetIsWin(param1);
      }
      
      public function LogicUpdate() : void
      {
         this.ProcessorBloodPurgatory.LogicUpdate();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_BLOODPURGATORY.BooldPurgatory_ResourceId);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FMcPanel = TUtilityReflection.CreateDisplayObjectInstance(CONST_BLOODPURGATORY.BooldPurgatory_MainId) as Sprite;
         addChild(this.FMcPanel);
         this.ProcessorBloodSoulPurgatory.setRootPanel(this.FMcPanel);
         this.FMcPanel.x = (FUICore.StageWidth - this.FMcPanel.width) / 2;
         this.FMcPanel.y = (FUICore.StageHeight - this.FMcPanel.height) / 2;
         this.FMcPanelBiood = TUtilityReflection.CreateDisplayObjectInstance(CONST_BLOODPURGATORY.BooldPurgatory_PartBloodId) as Sprite;
         addChild(this.FMcPanelBiood);
         this.ProcessorBloodSoul.setRootPanel(this.FMcPanelBiood);
         this.FMcPanelBiood.x = (FUICore.StageWidth - this.FMcPanelBiood.width) / 2;
         this.FMcPanelBiood.y = (FUICore.StageHeight - this.FMcPanelBiood.height) / 2;
         this.FMcPanelPurgatory = TUtilityReflection.CreateDisplayObjectInstance(CONST_BLOODPURGATORY.BooldPurgatory_PartCustomsId) as Sprite;
         addChild(this.FMcPanelPurgatory);
         this.ProcessorBloodPurgatory.setRootPanel(this.FMcPanelPurgatory);
         this.FMcPanelPurgatory.x = (FUICore.StageWidth - this.FMcPanelPurgatory.width) / 2;
         this.FMcPanelPurgatory.y = (FUICore.StageHeight - this.FMcPanelPurgatory.height) / 2;
         TGameUtil.setButtonMode(this.FMcPanel[CONST_BLOODPURGATORY.BooldPurgatory_MainId],true);
         super.ResourcesPerform_UIDispatch();
      }
      
      public function PlayerEffect() : void
      {
         MovieClip(this.FMcPanel["MC_EffectLeft"]).gotoAndPlay(1);
         MovieClip(this.FMcPanel["MC_EffectRight"]).gotoAndPlay(1);
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         SimpleButton(this.FMcPanel[CONST_BLOODPURGATORY.BooldPurgatory_CloseBtn]).addEventListener(MouseEvent.CLICK,this.CloseClick);
         super.ResourcesPerform_UILocations();
      }
      
      public function CloseClick(param1:MouseEvent) : void
      {
         FOnClose();
      }
      
      public function setInstance(param1:int) : void
      {
         this.ProcessorBloodPurgatory.setInstance(param1);
      }
      
      public function setVisibelByIndex(param1:int) : void
      {
         this.ProcessorBloodSoulPurgatory.setVisible(false);
         this.ProcessorBloodSoul.setVisible(false);
         this.ProcessorBloodPurgatory.setVisible(false);
         switch(param1)
         {
            case 0:
               this.ProcessorBloodSoulPurgatory.setVisible(true);
               this.PlayerEffect();
               this.ProcessorBloodSoulPurgatory.UpDateStuffBtn();
               break;
            case 1:
               this.ProcessorBloodSoul.setVisible(true);
               break;
            case 2:
               this.ProcessorBloodPurgatory.setVisible(true);
               this.ProcessorBloodPurgatory.ChallengeBtn(true);
               this.ProcessorBloodPurgatory.UpdtaMonsterId();
               this.ProcessorBloodPurgatory.BeginPlayerEffect();
         }
      }
      
      public function BloodSoulBtnFunF() : void
      {
         if(this.FBloodSoulBtnFun != null)
         {
            this.FBloodSoulBtnFun();
         }
      }
      
      public function ShortcutGetStuffBtnFunF() : void
      {
         if(this.FShortcutGetStuffBtnFun != null)
         {
            this.FShortcutGetStuffBtnFun();
         }
      }
      
      public function BloodSoulChangeBtnFunF() : void
      {
         if(this.FBloodSoulChangeBtnFun != null)
         {
            this.FBloodSoulChangeBtnFun();
         }
      }
      
      public function BloodSoulCloseBtnFunF(param1:int) : void
      {
         if(this.FBloodSoulCloseBtnFun != null)
         {
            this.FBloodSoulCloseBtnFun(param1);
         }
      }
      
      public function CBloodSoulBtnFunF() : void
      {
         if(this.FCBloodSoulBtnFun != null)
         {
            this.FCBloodSoulBtnFun();
         }
      }
      
      public function ChallengeBtnFunF() : void
      {
         if(this.FChallengeBtnFun != null)
         {
            this.FChallengeBtnFun();
         }
      }
      
      public function FAlonePopFrameF(param1:int, param2:int) : void
      {
         if(this.FAlonePopFrameFun != null)
         {
            this.FAlonePopFrameFun(param1,param2);
         }
      }
      
      public function FBtnOverBackFuncF(param1:int, param2:int, param3:int, param4:int) : void
      {
         this.FBtnOverBackFunc(param1,param2,param3,param4);
      }
      
      public function FBtnMoveBackFuncF(param1:int, param2:int) : void
      {
         this.FBtnMoveBackFunc(param1,param2);
      }
      
      public function FBtnOutBackFuncF(param1:int, param2:int) : void
      {
         this.FBtnOutBackFunc(param1,param2);
      }
      
      public function set GoToBloodPurgatoryPanel(param1:Function) : void
      {
         this.FGoToBloodPurgatoryPanel = param1;
      }
      
      public function GoToBloodPurgatoryPanelF(param1:String) : void
      {
         this.FGoToBloodPurgatoryPanel(param1);
      }
      
      public function CustomsTabFunF(param1:int) : void
      {
         if(this.FCustomsTabFun != null)
         {
            this.FCustomsTabFun(param1);
         }
      }
      
      public function SetGetStuffBtn(param1:Boolean) : void
      {
         this.ProcessorBloodSoulPurgatory.SetGetStuffBtn(param1);
         this.ProcessorBloodSoulPurgatory.UpDateStuffBtn();
      }
      
      public function GetLayerShut(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:TBloodSoul_battle = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         _loc5_ = param1;
         _loc6_ = this.GetCustom_battle(_loc5_);
         if(_loc6_)
         {
            _loc2_ = _loc6_.Location;
            _loc3_ = _loc6_.SStage;
            _loc4_ = _loc6_.SStageID;
            _loc5_++;
            _loc6_ = this.GetCustom_battle(_loc5_);
         }
         else
         {
            _loc2_ = 0;
            _loc3_ = 0;
            _loc4_ = 0;
            if(param1 == 0)
            {
               _loc5_ = 100001;
               _loc6_ = this.GetCustom_battle(_loc5_);
            }
         }
         if(!_loc6_)
         {
            this.ProcessorBloodPurgatory.SetFUIPetId(0);
            _loc7_ = 0;
            _loc8_ = 0;
         }
         else
         {
            if(_loc6_.Awards.length == 0)
            {
               _loc7_ = 0;
               _loc8_ = 0;
            }
            else
            {
               _loc7_ = int(_loc6_.Awards[0].Code);
               _loc8_ = int(_loc6_.Awards[0].Amount);
            }
            this.ProcessorBloodPurgatory.SetFUIPetId(_loc6_.Image,_loc6_.NeedLevel);
            this.UpdateReward(_loc6_.Showawards[0].Code,_loc6_.Showawards[0].Amount,_loc7_,_loc8_);
         }
         this.ProcessorBloodSoulPurgatory.GetCustomLayer(_loc2_,_loc3_,_loc4_,this.ProcessorBloodPurgatory);
         this.ProcessorBloodSoul.GetCustomLayer(_loc2_,_loc3_,_loc4_,param1);
      }
      
      public function UpdateReward(param1:int, param2:int, param3:int = 0, param4:int = 0) : void
      {
         this.FSelectInventories.Clear();
         this.FTempSelectInventoriesId.length = 0;
         this.FTempSelectInventoriesNum.length = 0;
         this.FTempSelectInventoriesId.push(param1);
         this.FTempSelectInventoriesNum.push(param2);
         if(param3 != 0)
         {
            this.FTempSelectInventoriesId.push(param3);
            this.FTempSelectInventoriesNum.push(param4);
         }
         this.UnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FSelectInventories,this.FTempSelectInventoriesId);
      }
      
      public function GetCustom_battle(param1:int) : TBloodSoul_battle
      {
         return SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BloodPurgatory_Battle,param1) as TBloodSoul_battle;
      }
      
      public function BloodSoulPurgatory_Initili_Ret(param1:ByteArray) : void
      {
         this.ProcessorBloodSoul.BloodSoulPurgatory_Initili_Ret(param1);
      }
      
      public function GetCustomLayerCopy() : void
      {
         this.ProcessorBloodSoul.GetCustomLayerCopy();
      }
      
      public function CustomBack(param1:int) : void
      {
         this.GetLayerShut(param1);
      }
      
      public function BloodSoulPurgatory_Practice_Ret(param1:ByteArray) : void
      {
         this.ProcessorBloodSoul.BloodSoulPurgatory_Practice_Ret(param1);
      }
      
      public function ZeroReset() : void
      {
         this.ProcessorBloodSoulPurgatory.ZeroReset();
         this.ProcessorBloodSoul.ZeroReset();
      }
      
      public function FreeSilverCount(param1:int) : void
      {
         this.ProcessorBloodSoul.FreeSilverCount(param1);
      }
      
      public function FStuffIdArrF(param1:Vector.<Object>) : void
      {
         this.ProcessorBloodSoul.FStuffIdArrF(param1);
      }
      
      public function FMore_High(param1:int) : void
      {
         this.ProcessorBloodSoul.FMore_High(param1);
      }
      
      public function set BloodSoulBtnFun(param1:Function) : void
      {
         this.FBloodSoulBtnFun = param1;
      }
      
      public function set ShortcutGetStuffBtnFun(param1:Function) : void
      {
         this.FShortcutGetStuffBtnFun = param1;
      }
      
      public function set BloodSoulChangeBtnFun(param1:Function) : void
      {
         this.FBloodSoulChangeBtnFun = param1;
      }
      
      public function set BloodSoulCloseBtnFun(param1:Function) : void
      {
         this.FBloodSoulCloseBtnFun = param1;
      }
      
      public function set CustomsTabFun(param1:Function) : void
      {
         this.FCustomsTabFun = param1;
      }
      
      public function set AlonePopFrameFun(param1:Function) : void
      {
         this.FAlonePopFrameFun = param1;
      }
      
      public function set CBloodSoulBtnFun(param1:Function) : void
      {
         this.FCBloodSoulBtnFun = param1;
      }
      
      public function set ChallengeBtnFun(param1:Function) : void
      {
         this.FChallengeBtnFun = param1;
      }
      
      public function set BtnOverBackFunc(param1:Function) : void
      {
         this.FBtnOverBackFunc = param1;
      }
      
      public function set BtnMoveBackFunc(param1:Function) : void
      {
         this.FBtnMoveBackFunc = param1;
      }
      
      public function set BtnOutBackFunc(param1:Function) : void
      {
         this.FBtnOutBackFunc = param1;
      }
      
      public function set IsExcel(param1:int) : void
      {
         this.FIsExcel = param1;
      }
      
      public function set UIComponentsHintOnOver(param1:Function) : void
      {
         this.FUIComponentsHintOnOver = param1;
      }
      
      public function set UIComponentsHintOnOut(param1:Function) : void
      {
         this.FUIComponentsHintOnOut = param1;
      }
      
      public function set Distant(param1:Function) : void
      {
         this.FDistant = param1;
      }
      
      public function set UIComponentsLittleOnOver(param1:Function) : void
      {
         this.FUIComponentsLittleOnOver = param1;
      }
      
      public function set UIComponentsLittleOnOut(param1:Function) : void
      {
         this.FUIComponentsLittleOnOut = param1;
      }
   }
}

