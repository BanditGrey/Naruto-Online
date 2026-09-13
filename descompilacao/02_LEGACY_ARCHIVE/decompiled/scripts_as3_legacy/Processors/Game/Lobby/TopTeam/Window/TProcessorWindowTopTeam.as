package Processors.Game.Lobby.TopTeam.Window
{
   import Foundation.Common.THint;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TPvpRankingReward;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.SLogicsCore;
   import Logics.TopTeam.TTopTeamData;
   import Processors.Game.Lobby.Common.TProcessorWindowTemplate;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Constants.CONST_TOPTEAM;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_TOPTEAM;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowTopTeam extends TProcessorWindowTemplate
   {
      
      protected static const QUALITY_MAX:uint = 6;
      
      protected var FTF_ActivityOpenTime:TextField;
      
      protected var FTF_PlayCount:TextField;
      
      protected var FMC_NinjaPointMall:MovieClip;
      
      protected var FMC_NinjaRank:MovieClip;
      
      protected var FRankingBoxVec:Vector.<MovieClip>;
      
      protected var FHintBoxTip:THint;
      
      protected var FTopTeamData:TTopTeamData;
      
      protected var FRankRatioSilvers:Vector.<Object>;
      
      protected var FRankRatioExps:Vector.<Object>;
      
      protected var FSilverRatio:Number;
      
      protected var FExpRatio:Number;
      
      protected var FPvpRewardBins:TBins;
      
      protected var FNinjaPointMallOnClick:Function;
      
      protected var FNinjaRankOnClick:Function;
      
      protected var FHintOnMove:Function;
      
      protected var FHintOnOut:Function;
      
      public function TProcessorWindowTopTeam(param1:TUIComponent)
      {
         super(param1);
         this.Init();
      }
      
      protected function Init() : void
      {
         this.FRankingBoxVec = new Vector.<MovieClip>(CONST_TOPTEAM.CAPACITY_Boxes);
         this.FHintBoxTip = new THint();
         this.FTopTeamData = SLogicsCore.TopTeamData;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_TOPTEAM.RESOURCESID_Swf_TOPTEAM);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         FMainUI = TUtilityReflection.CreateDisplayObjectInstance("MC_ActivityUnStart") as Sprite;
         UIDispatch();
         _loc2_ = CONST_TOPTEAM.CAPACITY_Boxes;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = FMainUI["MC_Boxes"]["MC_Box_" + _loc1_] as MovieClip;
            _loc3_.gotoAndStop(_loc1_ + 1);
            this.FRankingBoxVec[_loc1_] = _loc3_;
            _loc1_++;
         }
         this.FTF_ActivityOpenTime = FMainUI["TF_ActivityOpenTime"];
         this.FTF_PlayCount = FMainUI["TF_PlayCount"];
         this.FMC_NinjaPointMall = FMainUI["MC_NinjaPointMall"];
         TGameUtil.setButtonMode(this.FMC_NinjaPointMall,true);
         this.FMC_NinjaRank = FMainUI["MC_NinjaRank"];
         TGameUtil.setButtonMode(this.FMC_NinjaRank,true);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TSystemLanguage = null;
         UILocations();
         _loc2_ = CONST_TOPTEAM.CAPACITY_Boxes;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FRankingBoxVec[_loc1_];
            _loc3_.addEventListener(MouseEvent.MOUSE_MOVE,this.MCRewardOnOver,false,0,true);
            _loc3_.addEventListener(MouseEvent.MOUSE_OUT,this.MCRewardOnOut,false,0,true);
            _loc1_++;
         }
         this.FMC_NinjaPointMall.addEventListener(MouseEvent.CLICK,this.MCNinjaPointMallOnClick,false,0,true);
         this.FMC_NinjaRank.addEventListener(MouseEvent.CLICK,this.MCNinjaRankOnClick,false,0,true);
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.HELPTIPS_TopTeam) as TSystemLanguage;
         FHelpTips.Content = _loc4_.Desc;
         super.ResourcesPerform_UILocations();
      }
      
      override protected function ResourcesPerform_UIFinalize() : void
      {
         var _loc1_:TSystemLanguage = null;
         var _loc2_:TConfigValue = null;
         var _loc3_:Vector.<Object> = null;
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:int = 0;
         var _loc7_:uint = 0;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.HELPTIPS_TopTeam) as TSystemLanguage;
         FHelpTips.Content = _loc1_.Desc;
         _loc2_ = this.GetConfigValue(CONST_CONFIGVALUE.TEAMBATTLE_ACTIVITYTIMES);
         _loc3_ = _loc2_.Value as Vector.<Object>;
         _loc5_ = _loc3_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc7_ = uint(_loc3_[_loc4_].length);
            _loc6_ = 0;
            while(_loc6_ < _loc7_)
            {
               if(_loc3_[_loc4_][_loc6_] == 0)
               {
                  _loc3_[_loc4_][_loc6_] = "00";
               }
               _loc6_++;
            }
            _loc4_++;
         }
         this.FTF_ActivityOpenTime.text = TUtilityString.Format(STRING_TOPTEAM.FORMAT_ActivityTime,_loc3_[0][0],_loc3_[0][1],_loc3_[1][0],_loc3_[1][1],_loc3_[2][0],_loc3_[2][1],_loc3_[3][0],_loc3_[3][1]);
         _loc2_ = this.GetConfigValue(CONST_CONFIGVALUE.TEAMBATTLE_RANKRATIO_SILVER);
         this.FRankRatioSilvers = _loc2_.Value as Vector.<Object>;
         _loc2_ = this.GetConfigValue(CONST_CONFIGVALUE.TEAMBATTLE_RANKRATIO_EXP);
         this.FRankRatioExps = _loc2_.Value as Vector.<Object>;
         _loc2_ = this.GetConfigValue(CONST_CONFIGVALUE.TEAMBATTLE_SILVERRATIO);
         this.FSilverRatio = _loc2_.Value as Number;
         _loc2_ = this.GetConfigValue(CONST_CONFIGVALUE.TEAMBATTLE_EXPRATIO);
         this.FExpRatio = _loc2_.Value as Number;
         this.FPvpRewardBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_PvpRankingReward) as TBins;
         super.ResourcesPerform_UIFinalize();
      }
      
      protected function GetConfigValue(param1:uint) : TConfigValue
      {
         var _loc2_:TConfigValue = null;
         return SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,param1) as TConfigValue;
      }
      
      protected function MakeListHtmlText(param1:int, param2:uint, param3:uint, param4:uint) : String
      {
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:uint = 0;
         var _loc10_:int = 0;
         var _loc11_:uint = 0;
         var _loc12_:String = null;
         var _loc13_:Array = null;
         var _loc14_:String = null;
         var _loc15_:uint = 0;
         _loc12_ = "";
         _loc14_ = "";
         if(param3 > 1000)
         {
            param3 = 1000;
         }
         var _loc16_:int = int(SLogicsCore.Character.GetMainHeroLogicLevel(param4));
         _loc5_ = this.FRankRatioSilvers[param1][2] * this.FSilverRatio * uint(2000 * Math.pow(2,Number(_loc16_ / 20)) * Math.log(6561 / (param2 + 8)) / Math.log(3));
         _loc6_ = this.FRankRatioSilvers[param1][2] * this.FSilverRatio * uint(2000 * Math.pow(2,Number(_loc16_ / 20)) * Math.log(6561 / (param3 + 8)) / Math.log(3));
         _loc7_ = this.FRankRatioExps[param1][2] * this.FExpRatio * uint(2000 * Math.pow(2,Number(_loc16_ / 20)) * Math.log(6561 / (param2 + 8)) / Math.log(3));
         _loc8_ = this.FRankRatioExps[param1][2] * this.FExpRatio * uint(2000 * Math.pow(2,Number(_loc16_ / 20)) * Math.log(6561 / (param3 + 8)) / Math.log(3));
         _loc15_ = QUALITY_MAX - param1;
         _loc12_ = this.GetPvpRewardDesc(_loc15_,param4);
         _loc13_ = _loc12_.split("\\n");
         _loc11_ = _loc13_.length;
         _loc10_ = 0;
         while(_loc10_ < _loc11_)
         {
            _loc14_ += _loc13_[_loc10_] + "\n";
            _loc10_++;
         }
         _loc14_ += STRING_COMMON.ITEMNAME_Coin + " +" + uint(_loc5_) + "~" + uint(_loc6_) + "\n";
         _loc14_ = _loc14_ + (STRING_COMMON.ITEMNAME_Exp + " +" + uint(_loc7_) + "~" + uint(_loc8_) + "\n");
         return _loc14_ + TUtilityString.Format(STRING_TOPTEAM.FORMAT_Ranking_ListReward,param2,param3);
      }
      
      protected function GetPvpRewardDesc(param1:int, param2:uint) : String
      {
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:TPvpRankingReward = null;
         _loc4_ = uint(this.FPvpRewardBins.Count);
         _loc5_ = this.FPvpRewardBins.GetDatebaseByValue("Rewardid",param2 + "_" + param1) as TPvpRankingReward;
         if(_loc5_ != null)
         {
            return _loc5_.Tips;
         }
         return "";
      }
      
      protected function UpdateUI() : void
      {
         this.FTF_PlayCount.text = TUtilityString.Format(STRING_TOPTEAM.FORMAT_RestPlayCount,SLogicsCore.TopTeamData.RestPlayCount);
      }
      
      override protected function ButtonCloseOnClick(param1:MouseEvent) : void
      {
         super.ButtonCloseOnClick(param1);
      }
      
      protected function MCNinjaPointMallOnClick(param1:MouseEvent) : void
      {
         if(this.FNinjaPointMallOnClick != null)
         {
            this.FNinjaPointMallOnClick(this);
         }
      }
      
      protected function MCNinjaRankOnClick(param1:MouseEvent) : void
      {
         if(this.FNinjaRankOnClick != null)
         {
            this.FNinjaRankOnClick(this);
         }
      }
      
      protected function MCRewardOnOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:String = null;
         var _loc6_:Array = null;
         _loc5_ = "";
         _loc6_ = param1.currentTarget.name.split("_");
         _loc2_ = int(_loc6_[2]);
         _loc4_ = uint(SLogicsCore.Character.GetMainLevel());
         _loc5_ = this.MakeListHtmlText(_loc2_,this.FRankRatioSilvers[_loc2_][0],this.FRankRatioSilvers[_loc2_][1],_loc4_);
         this.FHintBoxTip.Caption = _loc5_;
         if(this.FHintOnMove != null)
         {
            this.FHintOnMove(this,this.FHintBoxTip);
         }
      }
      
      protected function MCRewardOnOut(param1:MouseEvent) : void
      {
         if(this.FHintOnOut != null)
         {
            this.FHintOnOut(this);
         }
      }
      
      public function set NinjaPointMallOnClick(param1:Function) : void
      {
         this.FNinjaPointMallOnClick = param1;
      }
      
      public function set NinjaRankOnClick(param1:Function) : void
      {
         this.FNinjaRankOnClick = param1;
      }
      
      public function get HintOnMove() : Function
      {
         return this.FHintOnMove;
      }
      
      public function set HintOnMove(param1:Function) : void
      {
         this.FHintOnMove = param1;
      }
      
      public function get HintOnOut() : Function
      {
         return this.FHintOnOut;
      }
      
      public function set HintOnOut(param1:Function) : void
      {
         this.FHintOnOut = param1;
      }
      
      public function Update() : void
      {
         this.UpdateUI();
      }
   }
}

