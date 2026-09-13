package Processors.Game.Lobby.BigDipper
{
   import Foundation.Common.TCoordinate;
   import Foundation.Common.THint;
   import Foundation.Fonts.SFontCore;
   import Foundation.Fonts.TFontEffect;
   import Foundation.Registries.*;
   import Foundation.Resources.*;
   import Foundation.Resources.Strings.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.*;
   import Logics.BigDipper.*;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Processors.Game.Common.Effects.Texts.TEffectCoordinateParameters;
   import Processors.Game.Common.Effects.Texts.TEffectTextParameters;
   import Processors.Game.Lobby.BigDipper.TigerMachine.*;
   import Processors.Game.Lobby.Common.*;
   import Resources.Constants.*;
   import Resources.Strings.STRING_BIGDIPPER;
   import Resources.Strings.STRING_COMMON;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   import flash.utils.setTimeout;
   
   public class TProcessorWindowBigDipper extends TProcessorLobbyWindow
   {
      
      protected static const COLOR_EffectText:uint = 4294440951;
      
      protected static const LEVELTEXT_PREFIX:String = STRING_COMMON.FORMAT_Level;
      
      protected static const DELAY:Vector.<int> = Vector.<int>([0,10,20]);
      
      protected static const STATE_BEGIN:int = -1;
      
      protected static const STATE_SETUP_TIGERMACHINE:int = 0;
      
      protected static const STATE_TIGERMACHINE:int = 1;
      
      protected static const STATE_SETUP_POWERMOVE:int = 2;
      
      protected static const STATE_POWERMOVE:int = 3;
      
      protected static const STATE_SETUP_SHOWINFOR:int = 4;
      
      protected static const STATE_SHOWINFOR:int = 5;
      
      public static const TYPE_ONETIMEUPGRADE:int = 0;
      
      public static const TYPE_ANYTIMEUPGRADE:int = 1;
      
      protected var FHelpTips:THint;
      
      protected var FEffectCoordinateParameters:TEffectCoordinateParameters;
      
      protected var FTextParameters:TEffectTextParameters;
      
      protected var FUIDispatchRoutines:Vector.<Function>;
      
      protected var FUILocationRoutines:Vector.<Function>;
      
      protected var FTFFreeTime:TextField;
      
      protected var FTFStarsLevel:TRegistryInstance;
      
      protected var FMCStars:TRegistryInstance;
      
      protected var FMCPower:MovieClip;
      
      protected var FBtnClose:SimpleButton;
      
      protected var FBtnHelp:SimpleButton;
      
      protected var FBtnOneTimeUpgrade:SimpleButton;
      
      protected var FBtnAnyTimeUpgrade:SimpleButton;
      
      protected var FBtnAnyTimeUpgradeCant:MovieClip;
      
      protected var FBigDipperTipData:TBigDipperTipData;
      
      protected var FNeedChangeTipData:Boolean;
      
      protected var FMC_Task:MovieClip = null;
      
      protected var FMC_PendantLeft:MovieClip;
      
      protected var FMC_PendantRight:MovieClip;
      
      protected var FMCTigerMachine:MovieClip;
      
      protected var FMCTigerMaChineShake:MovieClip;
      
      protected var FVectorFlashEyes:Vector.<MovieClip>;
      
      protected var FCanFlashStar:MovieClip;
      
      protected var FTigerMachines:Vector.<TTigerMachine>;
      
      protected var FTigerMachineRoutines:TRegistryRoutine;
      
      protected var FTigerMachineIFEqualFrameIDVec:Vector.<Boolean>;
      
      protected var FTigerMachineRandomFrameIDVec:Vector.<int>;
      
      protected var FTigerMachineCloneFrameIDVec:Vector.<int>;
      
      protected var FIsPlayerEffect:Boolean;
      
      protected var FTigerMachineRuning:Boolean;
      
      protected var FTigerMachineCurrentState:int;
      
      protected var FTigerMachinePreState:int;
      
      protected var FTigerMachineUpgradeMode:int;
      
      protected var FTigerMachineCurrentFrameIDIndex:int;
      
      protected var FMCCurrentPowerMove:MovieClip;
      
      protected var FMCCurrentPowerMoveStart:MovieClip;
      
      protected var FMCCurrentFlashStar:MovieClip;
      
      protected var FHintLeftBtn:THint;
      
      protected var FHintRightBtn:THint;
      
      protected var FHintVIPLow:THint;
      
      protected var FUseFreeTime:Boolean;
      
      protected var FStarsInfor:TStarsInfor;
      
      protected var FStarUpgradeInfor:TStarUpgradeInfor;
      
      protected var FOnMouseMove:Function;
      
      protected var FOnMouseOut:Function;
      
      protected var FHintOnOver:Function;
      
      protected var FHintOnOut:Function;
      
      protected var FOnHelpTipsOver:Function;
      
      protected var FOnHelpTipsOut:Function;
      
      protected var FOnOneTimeUpgrade:Function;
      
      protected var FOnAnyTimeUpgrade:Function;
      
      protected var FUpdateHeroPower:Function;
      
      public var nowMoney:int;
      
      protected var MainUI:MovieClip;
      
      public var OnUpdateFreeTime:Function;
      
      public function TProcessorWindowBigDipper(param1:TUIComponent)
      {
         super(param1);
         this.FHelpTips = new THint();
         this.ConstructEffectFields_Text();
         this.ConstructEffectParameters();
         this.ConstructDispatchRoutines();
         this.ConstructLocationRoutines();
      }
      
      protected function ConstructDispatchRoutines() : void
      {
         this.FUIDispatchRoutines = new Vector.<Function>();
         this.FUIDispatchRoutines.push(this.DispatchUIFreeTime);
         this.FUIDispatchRoutines.push(this.DispatchUIStarsLevel);
         this.FUIDispatchRoutines.push(this.DispatchUIStars);
         this.FUIDispatchRoutines.push(this.DispatchUIPower);
         this.FUIDispatchRoutines.push(this.DispatchUITigerMachine);
         this.FUIDispatchRoutines.push(this.DispatchUIBtn);
      }
      
      protected function ConstructEffectFields_Text() : void
      {
         var _loc1_:TFontEffect = null;
         this.FTextParameters = new TEffectTextParameters();
         this.FTextParameters.Font.Color = COLOR_EffectText;
         SFontCore.FontSelect(this.FTextParameters.Font,CONST_EFFECT.TEXT_BIGDIPPER_FontSetName,CONST_EFFECT.TEXT_BIGDIPPER_FontSetSize,CONST_EFFECT.TEXT_BIGDIPPER_FontSetBold);
         _loc1_ = this.FTextParameters.FontEffect;
         _loc1_.OutlineColor = 4280156160;
         _loc1_.OutlineIntensity = 7;
      }
      
      protected function ConstructEffectParameters() : void
      {
         this.FEffectCoordinateParameters = new TEffectCoordinateParameters();
         this.FEffectCoordinateParameters.VelocityY = -40;
         this.FEffectCoordinateParameters.FadeInTicks = 500;
         this.FEffectCoordinateParameters.FadeOutTicks = 400;
         this.FEffectCoordinateParameters.SustainTicks = 800;
         this.FEffectCoordinateParameters.PauseTicks = 0;
         this.FEffectCoordinateParameters.PauseSustainTicks = 0;
         this.FEffectCoordinateParameters.IsScale = true;
         this.FEffectCoordinateParameters.IsShakeEffect = false;
         this.FEffectCoordinateParameters.IsParallelOutput = false;
      }
      
      protected function ConstructLocationRoutines() : void
      {
         this.FUILocationRoutines = new Vector.<Function>();
         this.FUILocationRoutines.push(this.TigerMachineLocation);
         this.FUILocationRoutines.push(this.BtnLocation);
         this.FUILocationRoutines.push(this.StarsLocation);
         this.FUILocationRoutines.push(this.PowerLocation);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_BIGDIPPER.RESOURCESID_Swf_BIGDIPPER);
         super.ResourcesPerform_UIRequest();
      }
      
      public function updataViewData(param1:int, param2:int, param3:int) : void
      {
         this.nowMoney = param3;
         this.MainUI.TF_FreeTime.text = param1.toString();
         this.MainUI.TF_SiliverCost.text = param2.toString() + STRING_BIGDIPPER.COSTINTRODUCE;
         if(!this.FHintLeftBtn)
         {
            this.FHintLeftBtn = new THint();
         }
         this.FHintLeftBtn.Caption = STRING_BIGDIPPER.MouseOverBtnLeftString + param2.toString() + STRING_BIGDIPPER.COSTINTRODUCE;
         this.FHintOnOut(this);
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Function = null;
         this.MainUI = TUtilityReflection.CreateDisplayObjectInstance(CONST_BIGDIPPER.RESOURCE_ClassName_MC_BIGDIPPER) as MovieClip;
         addChild(this.MainUI);
         _loc1_ = 0;
         while(_loc1_ < this.FUIDispatchRoutines.length)
         {
            _loc2_ = this.FUIDispatchRoutines[_loc1_];
            _loc2_(this.MainUI);
            _loc1_++;
         }
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Function = null;
         _loc1_ = 0;
         while(_loc1_ < this.FUILocationRoutines.length)
         {
            _loc2_ = this.FUILocationRoutines[_loc1_];
            _loc2_();
            _loc1_++;
         }
         super.ResourcesPerform_UILocations();
      }
      
      protected function DispatchUIFreeTime(param1:MovieClip) : void
      {
         this.FTFFreeTime = param1[CONST_BIGDIPPER.RESOURCE_Link_TF_FreeTime];
      }
      
      protected function UpdateFreeTime() : void
      {
      }
      
      protected function DispatchUIStarsLevel(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TextField = null;
         this.FTFStarsLevel = new TRegistryInstance();
         _loc2_ = 0;
         while(_loc2_ < CONST_BIGDIPPER.STAR_NUM)
         {
            _loc3_ = param1[CONST_BIGDIPPER.RESOURCE_Link_TF_STAR + (_loc2_ + 1)];
            this.FTFStarsLevel.Register(CONST_BIGDIPPER.STARID[_loc2_],_loc3_);
            _loc2_++;
         }
      }
      
      protected function UpdateStarLevel() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < CONST_BIGDIPPER.STAR_NUM)
         {
            this.UpDateStarLevelByStarID(CONST_BIGDIPPER.STARID[_loc1_]);
            _loc1_++;
         }
      }
      
      protected function UpDateStarLevelByStarID(param1:uint) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:TextField = null;
         var _loc4_:TStarInfor = null;
         _loc4_ = this.FStarsInfor.GetStarByStarNameID(param1);
         if(_loc4_ != null)
         {
            _loc2_ = _loc4_.StarLevel;
         }
         _loc3_ = TextField(this.FTFStarsLevel.GetInstanceByIdentifier(param1));
         if(_loc4_ != null)
         {
            _loc3_.text = LEVELTEXT_PREFIX + _loc2_;
         }
      }
      
      protected function DispatchUIStars(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         this.FMCStars = new TRegistryInstance();
         _loc2_ = 0;
         while(_loc2_ < CONST_BIGDIPPER.STAR_NUM)
         {
            _loc3_ = param1[CONST_BIGDIPPER.RESOURCE_Link_MC_STAR + (_loc2_ + 1)];
            this.FMCStars.Register(CONST_BIGDIPPER.STARID[_loc2_],_loc3_);
            _loc2_++;
         }
      }
      
      protected function StarsLocation() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         _loc1_ = 0;
         while(_loc1_ < CONST_BIGDIPPER.STAR_NUM)
         {
            _loc2_ = MovieClip(this.FMCStars.GetInstanceByIndex(_loc1_));
            _loc2_.addEventListener(MouseEvent.MOUSE_MOVE,this.OnMouseMoveStar);
            _loc2_.addEventListener(MouseEvent.MOUSE_OUT,this.OnMouseOutStar);
            _loc1_++;
         }
      }
      
      protected function StopAllStar() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         _loc1_ = 0;
         while(_loc1_ < CONST_BIGDIPPER.STAR_NUM)
         {
            _loc2_ = MovieClip(this.FMCStars.GetInstanceByIdentifier(CONST_BIGDIPPER.STARID[_loc1_]));
            _loc2_.gotoAndStop("Start");
            _loc1_++;
         }
      }
      
      protected function StopStarFlashByStarID(param1:uint) : void
      {
         var _loc2_:MovieClip = null;
         _loc2_ = MovieClip(this.FMCStars.GetInstanceByIdentifier(param1));
         _loc2_.gotoAndStop("Start");
      }
      
      protected function FlashStarByStarID(param1:uint) : void
      {
         var _loc2_:MovieClip = null;
         _loc2_ = MovieClip(this.FMCStars.GetInstanceByIdentifier(param1));
         if(_loc2_)
         {
            _loc2_.gotoAndPlay("Start");
         }
      }
      
      protected function FlushTipData(param1:Event, param2:TBigDipperTipData) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:MovieClip = null;
         var _loc6_:uint = 0;
         var _loc7_:TStarInfor = null;
         _loc5_ = MovieClip(param1.currentTarget);
         _loc3_ = uint(this.FMCStars.GetIdentifierByInstance(_loc5_));
         _loc7_ = this.FStarsInfor.GetStarByStarNameID(_loc3_);
         param2.ResourceID = _loc7_.StarID;
         param2.StarName = _loc7_.StarName;
         param2.StarCurrentExp = _loc7_.CurrentExp.toString();
         param2.StarNeedExp = _loc7_.UpgradeNeedExp.toString();
         param2.CurrentLevelCeiling = _loc7_.CurrentLevelCeiling.toString();
         param2.StarAddAttrTypeName = _loc7_.AttributeName;
         param2.StarAddAttrValue = _loc7_.AttributeValue;
         param2.StarNextAddAttrValue = _loc7_.StarNextAddAttrValue;
         if(_loc7_.StarNextAddAttrValue == null)
         {
            param2.StarNextAddAttrTypeName = null;
         }
         else
         {
            param2.StarNextAddAttrTypeName = _loc7_.AttributeName;
         }
      }
      
      protected function DispatchUIPower(param1:MovieClip) : void
      {
         this.FMCPower = param1["MC_Power"];
      }
      
      protected function PowerLocation() : void
      {
         this.PowerMoveStarDispear();
      }
      
      protected function PowerMoveStarDispear() : void
      {
         this.FMCPower.visible = false;
      }
      
      protected function PowerMoveByStarID(param1:uint) : void
      {
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         this.FMCPower.visible = true;
         _loc2_ = this.GetFrameIDByStarID(param1);
         this.FMCPower.gotoAndStop(_loc2_);
         _loc3_ = this.FMCPower["MC_PowerMove"];
         this.FMCCurrentPowerMoveStart = _loc3_["MC_PowerStart"];
         _loc3_.gotoAndStop("Start");
         _loc3_.gotoAndPlay("Start");
      }
      
      protected function StopPowerMoveFlash() : void
      {
         if(this.FMCCurrentPowerMoveStart != null)
         {
            this.FMCCurrentPowerMoveStart.gotoAndStop("Start");
         }
      }
      
      protected function DispatchUIBtn(param1:MovieClip) : void
      {
         this.FBtnClose = param1[CONST_BIGDIPPER.RESOURCE_Link_BTN_Close];
         this.FBtnHelp = param1[CONST_BIGDIPPER.RESOURCE_Link_BTN_Help];
         this.FBtnOneTimeUpgrade = param1[CONST_BIGDIPPER.RESOURCE_Link_BTN_OneTimeUpgrade];
         this.FMC_Task = param1["MC_Task"];
         this.FMC_Task.buttonMode = true;
         this.FMC_Task.gotoAndStop(2);
         this.FBtnAnyTimeUpgrade = param1[CONST_BIGDIPPER.RESOURCE_Link_BTN_AnyTimeUpgrade];
         this.FBtnAnyTimeUpgradeCant = param1["Btn_Cant"];
         this.FHintLeftBtn = new THint();
         this.FHintRightBtn = new THint();
         this.FHintVIPLow = new THint();
         this.FHintLeftBtn.Caption = STRING_BIGDIPPER.MouseOverBtnLeftString + param1.TF_SiliverCost.text;
         this.FHintRightBtn.Caption = STRING_BIGDIPPER.MouseOverBtnRightString;
         this.FHintVIPLow.Caption = STRING_BIGDIPPER.MouseOverBtnVIPLow;
         this.FMC_PendantLeft = param1["mc_left_falling"];
         this.FMC_PendantRight = param1["mc_right_falling"];
      }
      
      protected function BtnLocation() : void
      {
         this.FBtnClose.addEventListener(MouseEvent.CLICK,this.CloseBtnClick);
         this.FBtnHelp.addEventListener(MouseEvent.MOUSE_MOVE,this.ButtonHelpOnOver,false,0,true);
         this.FBtnHelp.addEventListener(MouseEvent.MOUSE_OUT,this.ButtonHelpOnOut,false,0,true);
         this.FBtnOneTimeUpgrade.addEventListener(MouseEvent.CLICK,this.OneTimeOnMouseClick);
         this.FBtnOneTimeUpgrade.addEventListener(MouseEvent.MOUSE_MOVE,this.OnBtnMouseMove);
         this.FBtnOneTimeUpgrade.addEventListener(MouseEvent.MOUSE_OUT,this.OnBtnMouseOut);
         this.FBtnAnyTimeUpgrade.addEventListener(MouseEvent.CLICK,this.FiftyTimeOnMouseClick);
         this.FBtnAnyTimeUpgrade.addEventListener(MouseEvent.MOUSE_MOVE,this.OnBtnMouseMove);
         this.FBtnAnyTimeUpgrade.addEventListener(MouseEvent.MOUSE_OUT,this.OnBtnMouseOut);
         this.FBtnAnyTimeUpgradeCant.addEventListener(MouseEvent.MOUSE_MOVE,this.OnBtnMouseMove);
         this.FBtnAnyTimeUpgradeCant.addEventListener(MouseEvent.MOUSE_OUT,this.OnBtnMouseOut);
         this.FIsPlayerEffect = true;
         this.FMC_Task.addEventListener(MouseEvent.CLICK,this.ClICKHandl);
         this.FNeedChangeTipData = true;
      }
      
      public function ShackPendant() : void
      {
         this.FMC_PendantLeft.gotoAndPlay(1);
         this.FMC_PendantRight.gotoAndPlay(1);
      }
      
      protected function StopPendant() : void
      {
         this.FMC_PendantLeft.gotoAndStop(1);
         this.FMC_PendantRight.gotoAndStop(1);
      }
      
      protected function BtnsDisable() : void
      {
         this.FBtnClose.enabled = false;
         this.FBtnOneTimeUpgrade.enabled = false;
         this.FBtnAnyTimeUpgrade.enabled = false;
      }
      
      protected function BtnsEnable() : void
      {
         this.FBtnClose.enabled = true;
         this.FBtnOneTimeUpgrade.enabled = true;
         this.FBtnAnyTimeUpgrade.enabled = true;
      }
      
      protected function DispatchUITigerMachine(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TTigerMachine = null;
         var _loc4_:MovieClip = null;
         var _loc5_:MovieClip = null;
         this.FMCTigerMachine = param1["MC_TigerMachine"];
         this.FMCTigerMaChineShake = this.FMCTigerMachine["MC_Board"];
         _loc5_ = this.FMCTigerMaChineShake["MC_TigerMacineEyes"];
         this.FTigerMachines = new Vector.<TTigerMachine>();
         _loc2_ = 0;
         while(_loc2_ < CONST_BIGDIPPER.TigerMachineStarClassNum)
         {
            _loc4_ = _loc5_[CONST_BIGDIPPER.RESOURCE_Link_MC_StarSet + (_loc2_ + 1)];
            _loc3_ = new TTigerMachine(this,_loc4_);
            this.FMCTigerMaChineShake.addChild(_loc3_);
            _loc3_.x = CONST_BIGDIPPER.TigerMachineMotherBoardX + CONST_BIGDIPPER.TigerMachineTwoStarDistance * _loc2_;
            _loc3_.y = CONST_BIGDIPPER.TigerMachineMotherBoardY;
            this.FTigerMachines.push(_loc3_);
            _loc2_++;
         }
         this.FVectorFlashEyes = new Vector.<MovieClip>();
         _loc2_ = 0;
         while(_loc2_ < CONST_BIGDIPPER.FlashEyeNum)
         {
            _loc4_ = this.FMCTigerMaChineShake["MC_Eye" + (_loc2_ + 1)];
            this.FVectorFlashEyes.push(_loc4_);
            _loc2_++;
         }
      }
      
      protected function StopShake() : void
      {
         this.FMCTigerMachine.gotoAndStop("Start");
      }
      
      protected function StartShake() : void
      {
         this.FMCTigerMachine.gotoAndPlay("Start");
      }
      
      protected function StopFlashEye() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         while(_loc1_ < CONST_BIGDIPPER.FlashEyeNum)
         {
            _loc2_ = this.FVectorFlashEyes[_loc1_];
            _loc2_.gotoAndStop("Start");
            _loc1_++;
         }
      }
      
      protected function StarFlashEye() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         while(_loc1_ < CONST_BIGDIPPER.FlashEyeNum)
         {
            _loc2_ = this.FVectorFlashEyes[_loc1_];
            _loc2_.gotoAndPlay("Start");
            _loc1_++;
         }
      }
      
      protected function GetIndexByStarID(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc3_:Vector.<uint> = null;
         _loc3_ = CONST_BIGDIPPER.STARID;
         return int(_loc3_.indexOf(param1));
      }
      
      protected function GetFrameIDByStarID(param1:uint) : int
      {
         var _loc2_:int = 0;
         _loc2_ = this.GetIndexByStarID(param1);
         if(_loc2_ == -1)
         {
            return -1;
         }
         return CONST_BIGDIPPER.MoveFrameMoveTurn[_loc2_];
      }
      
      protected function RangeRandomNum(param1:int, param2:int) : int
      {
         return Math.random() * (param2 - param1) + param1;
      }
      
      protected function ConfuseVector(param1:Vector.<int>) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = this.RangeRandomNum(0,param1.length);
            _loc4_ = this.RangeRandomNum(0,param1.length);
            _loc5_ = param1[_loc3_];
            param1[_loc3_] = param1[_loc4_];
            param1[_loc4_] = _loc5_;
            _loc2_++;
         }
      }
      
      protected function SetVectorByData(param1:Vector.<int>, param2:uint, param3:int) : void
      {
         var _loc4_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < param3)
         {
            param1[_loc4_] = param2;
            _loc4_++;
         }
      }
      
      protected function SetVectorByVecotor(param1:Vector.<uint>, param2:Vector.<uint>) : void
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            param2[_loc3_] = param1[_loc3_];
            _loc3_++;
         }
      }
      
      protected function CloneFrameTurn(param1:Vector.<int>, param2:Vector.<int>) : void
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            param2[_loc3_] = param1[_loc3_];
            _loc3_++;
         }
      }
      
      protected function CreateRandomFrameID(param1:int, param2:Vector.<int>) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc4_ = this.GetFrameIDByStarID(param1);
         this.CloneFrameTurn(CONST_BIGDIPPER.MoveFrameMoveTurn,this.FTigerMachineCloneFrameIDVec);
         _loc3_ = this.GetIndexByStarID(param1);
         this.FTigerMachineCloneFrameIDVec.splice(_loc3_,1);
         this.ConfuseVector(this.FTigerMachineCloneFrameIDVec);
         switch(this.FStarUpgradeInfor.ResultID)
         {
            case CONST_BIGDIPPER.RESULT_ZERO_STAR_HITED_ID:
               param2[0] = this.FTigerMachineCloneFrameIDVec[0];
               param2[1] = this.FTigerMachineCloneFrameIDVec[1];
               param2[2] = this.FTigerMachineCloneFrameIDVec[2];
               break;
            case CONST_BIGDIPPER.RESULT_TWO_STAR_HITED_ID:
               this.SetVectorByData(param2,_loc4_,2);
               param2[2] = this.FTigerMachineCloneFrameIDVec[0];
               this.ConfuseVector(this.FTigerMachineRandomFrameIDVec);
               break;
            case CONST_BIGDIPPER.RESULT_THREE_STAR_HITED_ID:
               this.SetVectorByData(param2,_loc4_,3);
         }
      }
      
      protected function RandomIDVectorIfEqualFrameID(param1:Vector.<int>, param2:int, param3:Vector.<Boolean>) : void
      {
         var _loc4_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            if(param1[_loc4_] == param2)
            {
               param3[_loc4_] = true;
            }
            else
            {
               param3[_loc4_] = false;
            }
            _loc4_++;
         }
      }
      
      protected function SetTigerMachine(param1:Vector.<int>, param2:Number, param3:Vector.<Boolean>) : void
      {
         var _loc4_:TTigerMachine = null;
         var _loc5_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < CONST_BIGDIPPER.TigerMachineStarClassNum)
         {
            _loc4_ = this.FTigerMachines[_loc5_];
            _loc4_.Setup(param1[_loc5_],DELAY[_loc5_],param2,param3[_loc5_],false);
            _loc4_.Move();
            _loc5_++;
         }
      }
      
      protected function FlyText() : void
      {
         switch(this.FStarUpgradeInfor.ResultID)
         {
            case CONST_BIGDIPPER.RESULT_ZERO_STAR_HITED_ID:
               this.FlyTextDontHit();
               break;
            case CONST_BIGDIPPER.RESULT_TWO_STAR_HITED_ID:
               this.FlyTextHitTwo();
               break;
            case CONST_BIGDIPPER.RESULT_THREE_STAR_HITED_ID:
               this.FlyTextHitThree();
               break;
            case CONST_BIGDIPPER.RESULT_UPGRADEANYTIME_ID:
               this.FlyTextUpgradeAnyTime();
         }
      }
      
      protected function FlyTextDontHit() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         if(this.FUseFreeTime)
         {
            return;
         }
         _loc1_ = this.nowMoney * 0.7;
         _loc2_ = TUtilityString.Format(STRING_BIGDIPPER.FORMAT_HitNone,_loc1_);
         FOnEffectText(this,_loc2_,null,null);
      }
      
      protected function FlyTextHitTwo() : void
      {
         var _loc1_:uint = 0;
         _loc1_ = this.GetHitedStarID();
         this.FlyTextHaveHited(STRING_BIGDIPPER.FORMAT_HitTwo,0,_loc1_);
         var _loc2_:String = TUtilityString.Format(STRING_BIGDIPPER.FORMAT_UpgradeAnyTimeLastTime,this.nowMoney * 0.2);
         setTimeout(this.FeffectTow,800,_loc2_);
      }
      
      protected function FeffectTow(param1:String) : void
      {
         EffectGenerateText(param1);
      }
      
      protected function FlyTextHitThree() : void
      {
         var _loc1_:uint = 0;
         _loc1_ = this.GetHitedStarID();
         this.FlyTextHaveHited(STRING_BIGDIPPER.FORMAT_HitThree,0,_loc1_);
      }
      
      protected function FlyTextUpgradeAnyTime() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:uint = 0;
         var _loc3_:String = null;
         var _loc4_:TStarInfor = null;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc7_:int = 0;
         if(this.FTigerMachineCurrentFrameIDIndex >= CONST_BIGDIPPER.STAR_NUM)
         {
            _loc5_ = this.nowMoney * (50 - this.FStarUpgradeInfor.CostFreeTime) - this.FStarUpgradeInfor.CostMoney;
            _loc3_ = TUtilityString.Format(STRING_BIGDIPPER.FORMAT_UpgradeAnyTimeLastTime,_loc5_);
            EffectGenerateText(_loc3_);
         }
         else
         {
            _loc7_ = this.FStarUpgradeInfor.GetReceiveExperienceByStarID(CONST_BIGDIPPER.STARID[this.FTigerMachineCurrentFrameIDIndex]);
            if(_loc7_ == 0)
            {
               _loc6_ = STRING_BIGDIPPER.FORMAT_HitZero;
            }
            else if(_loc7_ < 0)
            {
               _loc6_ = STRING_BIGDIPPER.FORMAT_MaxLevel;
            }
            else
            {
               _loc6_ = STRING_BIGDIPPER.FORMAT_HitThree;
            }
            this.FlyTextHaveHited(_loc6_,this.FTigerMachineCurrentFrameIDIndex,CONST_BIGDIPPER.STARID[this.FTigerMachineCurrentFrameIDIndex]);
         }
      }
      
      protected function FlyTextHaveHited(param1:String, param2:int, param3:int) : void
      {
         var _loc4_:MovieClip = null;
         var _loc5_:String = null;
         var _loc6_:TStarInfor = null;
         var _loc7_:TCoordinate = null;
         var _loc8_:int = 0;
         _loc4_ = this.FMCStars.GetInstanceByIdentifier(param3) as MovieClip;
         _loc6_ = this.FStarsInfor.GetStarByStarNameID(param3);
         _loc7_ = TUtilityCartisian.GetScreenCoordinateByDisplayObject(_loc4_);
         _loc7_.X += _loc4_.width / 2;
         _loc7_.Y += _loc4_.height / 2;
         this.FEffectCoordinateParameters.CoordinateSource.Assign(_loc7_);
         _loc8_ = this.FStarUpgradeInfor.GetReceiveExperienceByStarID(param3);
         if(_loc8_ >= 0)
         {
            _loc5_ = TUtilityString.Format(param1,_loc6_.StarName,_loc8_);
         }
         else
         {
            _loc5_ = TUtilityString.Format(STRING_BIGDIPPER.FORMAT_MaxLevel,_loc6_.StarName);
         }
         EffectGenerateText(_loc5_,this.FTextParameters,this.FEffectCoordinateParameters);
      }
      
      protected function GetHitedStarID() : uint
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < CONST_BIGDIPPER.STAR_NUM)
         {
            _loc3_ = this.FStarUpgradeInfor.GetReceiveExperienceByIndex(_loc2_);
            if(_loc3_ != 0)
            {
               return int(CONST_BIGDIPPER.STARID[_loc2_]);
            }
            _loc2_++;
         }
         return 0;
      }
      
      protected function TigerMachineLocation() : void
      {
         this.FTigerMachineRoutines = new TRegistryRoutine();
         this.FTigerMachineRoutines.Register(STATE_BEGIN,this.StatePerform_Begin);
         this.FTigerMachineRoutines.Register(STATE_SETUP_TIGERMACHINE,this.StatePerform_SetupTigerMachine);
         this.FTigerMachineRoutines.Register(STATE_TIGERMACHINE,this.StatePerform_TigerMachine);
         this.FTigerMachineRoutines.Register(STATE_SETUP_POWERMOVE,this.StatePerform_SetupPowerMove);
         this.FTigerMachineRoutines.Register(STATE_POWERMOVE,this.StatePerform_PowerMove);
         this.FTigerMachineRoutines.Register(STATE_SETUP_SHOWINFOR,this.StatePerform_SetupShowinfor);
         this.FTigerMachineRoutines.Register(STATE_SHOWINFOR,this.StatePerform_Showinfor);
         this.FTigerMachineIFEqualFrameIDVec = new Vector.<Boolean>(CONST_BIGDIPPER.TigerMachineStarClassNum);
         this.FTigerMachineRandomFrameIDVec = new Vector.<int>(CONST_BIGDIPPER.TigerMachineStarClassNum);
         this.FTigerMachineCloneFrameIDVec = new Vector.<int>();
         this.FBigDipperTipData = new TBigDipperTipData();
         this.FTigerMachineRuning = true;
         this.StopTigerMachine();
      }
      
      override protected function LogicsPerform() : void
      {
         if(this.FTigerMachineRuning)
         {
            this.TigerMachineAnimation();
         }
      }
      
      protected function TigerMachineAnimation() : void
      {
         var _loc1_:Function = null;
         while(this.FTigerMachineRuning)
         {
            this.FTigerMachinePreState = this.FTigerMachineCurrentState;
            _loc1_ = this.FTigerMachineRoutines.GetRoutineByIndentifier(this.FTigerMachineCurrentState);
            if(_loc1_ != null)
            {
               _loc1_();
            }
            if(this.FTigerMachinePreState == this.FTigerMachineCurrentState)
            {
               return;
            }
         }
      }
      
      protected function StatePerform_Begin() : void
      {
         if(this.FTigerMachineUpgradeMode == TYPE_ANYTIMEUPGRADE)
         {
            this.StartShake();
         }
         this.FTigerMachineCurrentState = STATE_SETUP_TIGERMACHINE;
      }
      
      protected function StatePerform_SetupTigerMachine() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc1_ = int(this.GetHitedStarID());
         _loc2_ = this.GetFrameIDByStarID(_loc1_);
         switch(this.FTigerMachineUpgradeMode)
         {
            case TYPE_ONETIMEUPGRADE:
               this.CreateRandomFrameID(_loc1_,this.FTigerMachineRandomFrameIDVec);
               this.RandomIDVectorIfEqualFrameID(this.FTigerMachineRandomFrameIDVec,_loc2_,this.FTigerMachineIFEqualFrameIDVec);
               this.SetTigerMachine(this.FTigerMachineRandomFrameIDVec,TTigerMachine.SPEEDMIN,this.FTigerMachineIFEqualFrameIDVec);
               break;
            case TYPE_ANYTIMEUPGRADE:
               this.SetVectorByData(this.FTigerMachineRandomFrameIDVec,CONST_BIGDIPPER.MoveFrameMoveTurn[this.FTigerMachineCurrentFrameIDIndex],3);
               this.RandomIDVectorIfEqualFrameID(this.FTigerMachineRandomFrameIDVec,CONST_BIGDIPPER.MoveFrameMoveTurn[this.FTigerMachineCurrentFrameIDIndex],this.FTigerMachineIFEqualFrameIDVec);
               this.SetTigerMachine(this.FTigerMachineRandomFrameIDVec,TTigerMachine.SPEEDMAX,this.FTigerMachineIFEqualFrameIDVec);
         }
         this.StarFlashEye();
         this.FTigerMachineCurrentState = STATE_TIGERMACHINE;
      }
      
      protected function StatePerform_TigerMachine() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TTigerMachine = null;
         _loc1_ = 0;
         while(_loc1_ < CONST_BIGDIPPER.TigerMachineStarClassNum)
         {
            _loc2_ = this.FTigerMachines[_loc1_];
            if(_loc2_.Running)
            {
               return;
            }
            _loc1_++;
         }
         switch(this.FTigerMachineUpgradeMode)
         {
            case TYPE_ONETIMEUPGRADE:
               this.StopFlashEye();
               break;
            case TYPE_ANYTIMEUPGRADE:
         }
         this.FTigerMachineCurrentState = STATE_SETUP_POWERMOVE;
      }
      
      protected function StatePerform_SetupPowerMove() : void
      {
         var _loc1_:uint = 0;
         switch(this.FTigerMachineUpgradeMode)
         {
            case TYPE_ONETIMEUPGRADE:
               if(this.FStarUpgradeInfor.ResultID == CONST_BIGDIPPER.RESULT_ZERO_STAR_HITED_ID)
               {
                  this.StopTigerMachine();
                  this.FlyText();
                  return;
               }
               _loc1_ = this.GetHitedStarID();
               break;
            case TYPE_ANYTIMEUPGRADE:
               _loc1_ = CONST_BIGDIPPER.STARID[this.FTigerMachineCurrentFrameIDIndex];
         }
         this.PowerMoveByStarID(_loc1_);
         this.FMCCurrentPowerMove = this.FMCPower["MC_PowerMove"];
         this.FTigerMachineCurrentState = STATE_POWERMOVE;
      }
      
      protected function StatePerform_PowerMove() : void
      {
         if(this.FMCCurrentPowerMove.currentFrameLabel == "End")
         {
            this.StopPowerMoveFlash();
            this.FTigerMachineCurrentState = STATE_SETUP_SHOWINFOR;
         }
      }
      
      protected function StatePerform_SetupShowinfor() : void
      {
         var _loc1_:uint = 0;
         switch(this.FTigerMachineUpgradeMode)
         {
            case TYPE_ONETIMEUPGRADE:
               _loc1_ = this.GetHitedStarID();
               break;
            case TYPE_ANYTIMEUPGRADE:
               _loc1_ = CONST_BIGDIPPER.STARID[this.FTigerMachineCurrentFrameIDIndex];
         }
         this.UpDateStarLevelByStarID(_loc1_);
         this.FlashStarByStarID(_loc1_);
         this.FMCCurrentFlashStar = MovieClip(this.FMCStars.GetInstanceByIdentifier(_loc1_));
         this.FTigerMachineCurrentState = STATE_SHOWINFOR;
         this.FlyText();
      }
      
      protected function StatePerform_Showinfor() : void
      {
         if(this.FMCCurrentFlashStar != null && this.FMCCurrentFlashStar.currentFrameLabel == "End")
         {
            this.FMCCurrentFlashStar.gotoAndStop("Start");
            switch(this.FTigerMachineUpgradeMode)
            {
               case TYPE_ONETIMEUPGRADE:
                  this.StopTigerMachine();
                  return;
               case TYPE_ANYTIMEUPGRADE:
                  ++this.FTigerMachineCurrentFrameIDIndex;
                  this.FTigerMachineCurrentState = STATE_SETUP_TIGERMACHINE;
                  if(this.FTigerMachineCurrentFrameIDIndex >= CONST_BIGDIPPER.STAR_NUM)
                  {
                     this.FlyText();
                     this.StopTigerMachine();
                  }
            }
         }
      }
      
      public function StopTigerMachine() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TTigerMachine = null;
         if(this.FTigerMachineRuning)
         {
            this.StopShake();
            this.StopFlashEye();
            this.StopAllStar();
            this.StopPowerMoveFlash();
         }
         _loc1_ = 0;
         while(_loc1_ < CONST_BIGDIPPER.TigerMachineStarClassNum)
         {
            _loc2_ = this.FTigerMachines[_loc1_];
            _loc2_.StopFlash();
            _loc1_++;
         }
         this.FTigerMachineCurrentFrameIDIndex = 0;
         this.FTigerMachineRuning = false;
         this.FTigerMachineCurrentState = STATE_BEGIN;
         if(this.FStarUpgradeInfor != null && this.FStarUpgradeInfor.ResultID != CONST_BIGDIPPER.RESULT_ZERO_STAR_HITED_ID)
         {
            if(this.FUpdateHeroPower != null)
            {
               this.FUpdateHeroPower(this,SLogicsCore.Character.Heros.GetHeroByIndex(0).Identifier);
            }
         }
         this.BtnsEnable();
      }
      
      public function StopTigerMachineRoll() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TTigerMachine = null;
         _loc1_ = 0;
         while(_loc1_ < CONST_BIGDIPPER.TigerMachineStarClassNum)
         {
            _loc2_ = this.FTigerMachines[_loc1_];
            _loc2_.Stop();
            _loc1_++;
         }
      }
      
      protected function VipCheck() : void
      {
         this.FBtnAnyTimeUpgrade.visible = SLogicsCore.Character.VipData.OneTimeTrain;
         this.FBtnAnyTimeUpgradeCant.visible = !SLogicsCore.Character.VipData.OneTimeTrain;
      }
      
      protected function OneTimeOnMouseClick(param1:MouseEvent) : void
      {
         if(this.OnUpdateFreeTime != null)
         {
            this.OnUpdateFreeTime();
         }
         if(this.FTigerMachineRuning)
         {
            return;
         }
         if(this.FStarsInfor.FreeTime <= 0)
         {
            if(SLogicsCore.Character.CreditSilverCoin.ToNumber() < 100000)
            {
               EffectGenerateText(STRING_COMMON.NOTENOUGH_Coin);
               return;
            }
         }
         this.FUseFreeTime = this.FStarsInfor.FreeTime > 0;
         this.BtnsDisable();
         if(this.FOnOneTimeUpgrade != null)
         {
            this.FOnOneTimeUpgrade();
            this.FNeedChangeTipData = true;
         }
         TutorialNextStep(1700);
      }
      
      protected function FiftyTimeOnMouseClick(param1:MouseEvent) : void
      {
         if(this.FTigerMachineRuning)
         {
            return;
         }
         if(!SLogicsCore.Character.VipData.OneTimeTrain)
         {
            return;
         }
         if(SLogicsCore.Character.CreditSilverCoin.ToNumber() < 5000000)
         {
            EffectGenerateText(STRING_COMMON.NOTENOUGH_Coin);
            return;
         }
         this.BtnsDisable();
         if(this.FOnAnyTimeUpgrade != null)
         {
            this.FOnAnyTimeUpgrade();
            this.FNeedChangeTipData = true;
         }
      }
      
      protected function CloseBtnClick(param1:MouseEvent) : void
      {
         if(this.FTigerMachineRuning)
         {
            return;
         }
         this.StopTigerMachine();
         this.StopTigerMachineRoll();
         if(FOnClose != null)
         {
            FOnClose(this);
         }
         this.StopPendant();
      }
      
      protected function ButtonHelpOnOver(param1:MouseEvent) : void
      {
         var _loc2_:TSystemLanguage = null;
         if(this.FOnHelpTipsOver != null)
         {
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.HELPTIPS_BigDipper) as TSystemLanguage;
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
      
      protected function OnMouseMoveStar(param1:MouseEvent) : void
      {
         if(this.FOnMouseMove != null)
         {
            this.FlushTipData(param1,this.FBigDipperTipData);
            this.FOnMouseMove(this,this.FBigDipperTipData);
         }
      }
      
      protected function OnMouseOutStar(param1:MouseEvent) : void
      {
         if(this.FOnMouseOut != null)
         {
            this.FOnMouseOut(this);
         }
      }
      
      protected function OnBtnMouseMove(param1:MouseEvent) : void
      {
         var _loc2_:THint = null;
         var _loc3_:SimpleButton = null;
         if(param1.currentTarget is MovieClip)
         {
            _loc2_ = this.FHintVIPLow;
         }
         else
         {
            _loc3_ = param1.currentTarget as SimpleButton;
            if(_loc3_ == this.FBtnAnyTimeUpgrade)
            {
               _loc2_ = this.FHintRightBtn;
            }
            else
            {
               _loc2_ = this.FHintLeftBtn;
            }
         }
         if(this.FHintOnOver != null)
         {
            this.FHintOnOver(this,_loc2_);
         }
      }
      
      protected function OnBtnMouseOut(param1:MouseEvent) : void
      {
         if(this.FHintOnOut != null)
         {
            this.FHintOnOut(this);
         }
      }
      
      public function set OnOneTimeUpgrade(param1:Function) : void
      {
         this.FOnOneTimeUpgrade = param1;
      }
      
      public function set OnAnyTimeUpgrade(param1:Function) : void
      {
         this.FOnAnyTimeUpgrade = param1;
      }
      
      public function set StarsInfor(param1:TStarsInfor) : void
      {
         this.FStarsInfor = param1;
      }
      
      public function set StarUpgradeInfor(param1:TStarUpgradeInfor) : void
      {
         this.FStarUpgradeInfor = param1;
      }
      
      public function set OnMouseMove(param1:Function) : void
      {
         this.FOnMouseMove = param1;
      }
      
      public function set OnMouseOut(param1:Function) : void
      {
         this.FOnMouseOut = param1;
      }
      
      public function set HintOnOver(param1:Function) : void
      {
         this.FHintOnOver = param1;
      }
      
      public function set HintOnOut(param1:Function) : void
      {
         this.FHintOnOut = param1;
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
      
      public function set UpdateHeroPower(param1:Function) : void
      {
         this.FUpdateHeroPower = param1;
      }
      
      public function UpdateStarsInfor() : void
      {
         this.UpdateStarLevel();
         this.UpdateFreeTime();
         this.VipCheck();
      }
      
      protected function ClICKHandl(param1:MouseEvent) : void
      {
         this.FMC_Task.gotoAndStop(this.FMC_Task.currentFrame == 2 ? 1 : 2);
         this.FIsPlayerEffect = this.FMC_Task.currentFrame == 2 ? true : false;
      }
      
      public function UpdateStarsUpgradeInfor(param1:int) : void
      {
         var _loc2_:int = 0;
         this.FTigerMachineUpgradeMode = param1;
         this.UpdateFreeTime();
         if(this.FIsPlayerEffect)
         {
            this.FTigerMachineRuning = true;
         }
         else
         {
            if(this.FTigerMachineUpgradeMode == TYPE_ANYTIMEUPGRADE)
            {
               _loc2_ = 0;
               while(_loc2_ < CONST_BIGDIPPER.STAR_NUM + 1)
               {
                  this.FlyText();
                  ++this.FTigerMachineCurrentFrameIDIndex;
                  _loc2_++;
               }
               this.FTigerMachineCurrentFrameIDIndex = 0;
            }
            else
            {
               this.FlyText();
            }
            this.BtnsEnable();
         }
      }
   }
}

