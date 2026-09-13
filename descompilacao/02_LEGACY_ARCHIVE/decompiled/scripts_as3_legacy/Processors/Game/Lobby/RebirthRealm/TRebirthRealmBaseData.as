package Processors.Game.Lobby.RebirthRealm
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Logics.DatebaseVO.VO.Json.TFixedAward;
   import Logics.DatebaseVO.VO.TRebirth;
   import Logics.DatebaseVO.VO.TRebirth_battle;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_COMMON;
   
   public class TRebirthRealmBaseData
   {
      
      protected var FTodayChallengeTimes:int;
      
      protected var FTurntableTurnTimes:int;
      
      protected var FtodayChallengeType:int;
      
      protected var FAssisttodayChallengeType:int;
      
      protected var FCurCustomId:int;
      
      protected var FSixSamsaraId:int;
      
      protected var FSixSamsaraName:String = "";
      
      protected var FSixSamsaraAttribute:Array;
      
      protected var FSixSamsaraNextAttribute:Array;
      
      protected var FSixSamsaraStuffNum:int;
      
      protected var FSixSamsaraLevel:int;
      
      protected var FSixSamsaraIsOver:Boolean;
      
      protected var FSixSamsaraStuffId:int;
      
      protected var FSixSamsaraAttributeDescribe:Array;
      
      protected var FAddAttributeVec1_Obj:Vector.<Object>;
      
      protected var FAddAttributeVec2_Obj:Vector.<Object>;
      
      protected var FAddAttributeVec3_Obj:Vector.<Object>;
      
      protected var FAttribNum:Number;
      
      protected var FAttribType:int;
      
      protected var FTurntabledType:int;
      
      protected var FTurntabledValue:int;
      
      protected var FCustomImageVec1:Vector.<int>;
      
      protected var FCustomImageVec2:Vector.<int>;
      
      protected var FCustomImageVec3:Vector.<int>;
      
      protected var FCustomImageVec4:Vector.<int>;
      
      protected var FCustomImageVec5:Vector.<int>;
      
      protected var FCustomImageVec6:Vector.<int>;
      
      protected var FCustomImageVec7:Vector.<int>;
      
      protected var FCustomImageVec8:Vector.<int>;
      
      protected var FCustomImageVec9:Vector.<int>;
      
      protected var FCustomImageName1:Vector.<String>;
      
      protected var FCustomImageName2:Vector.<String>;
      
      protected var FCustomImageName3:Vector.<String>;
      
      protected var FCustomImageName4:Vector.<String>;
      
      protected var FCustomImageName5:Vector.<String>;
      
      protected var FCustomImageName6:Vector.<String>;
      
      protected var FCustomImageName7:Vector.<String>;
      
      protected var FCustomImageName8:Vector.<String>;
      
      protected var FCustomImageName9:Vector.<String>;
      
      protected var FAllCustomNum:int;
      
      protected var FCurCustomBig:int;
      
      protected var FCurCustomLittle:int;
      
      protected var FNextCustomBig:int;
      
      protected var FNextCustomLittle:int;
      
      protected var FCommonCustomRecommendPower:int;
      
      protected var FDifficultyCustomRecommendPower:int;
      
      protected var FHellCustomRecommendPower:int;
      
      protected var FCommonCustomRecommendPower2:int;
      
      protected var FDifficultyCustomRecommendPower2:int;
      
      protected var FHellCustomRecommendPower2:int;
      
      protected var FCommonCustomRecommendPower3:int;
      
      protected var FDifficultyCustomRecommendPower3:int;
      
      protected var FHellCustomRecommendPower3:int;
      
      protected var FIsPassCustom:Boolean;
      
      protected var FCurCustomDropReward:Vector.<TFixedAward>;
      
      protected var FAllCustomDropReward1:Array;
      
      protected var FAllCustomDropReward2:Array;
      
      protected var FAllCustomDropReward3:Array;
      
      protected var FAllCustomDropReward4:Array;
      
      protected var FAllCustomDropReward5:Array;
      
      protected var FAllCustomDropReward6:Array;
      
      protected var FAllCustomDropReward7:Array;
      
      protected var FAllCustomDropReward8:Array;
      
      protected var FAllCustomDropReward9:Array;
      
      protected var FTurntableIsCanMove:Boolean = true;
      
      protected var FAutoBtnIsCanClcik:Vector.<uint>;
      
      protected var FAutoFireGetRewardCount:uint;
      
      protected var FRebirth:TBins;
      
      protected var FRebirth_battle:TBins;
      
      public function TRebirthRealmBaseData()
      {
         super();
         this.FAddAttributeVec1_Obj = new Vector.<Object>();
         this.FAddAttributeVec2_Obj = new Vector.<Object>();
         this.FAddAttributeVec3_Obj = new Vector.<Object>();
         this.FCustomImageVec1 = new Vector.<int>();
         this.FCustomImageVec2 = new Vector.<int>();
         this.FCustomImageVec3 = new Vector.<int>();
         this.FCustomImageVec4 = new Vector.<int>();
         this.FCustomImageVec5 = new Vector.<int>();
         this.FCustomImageVec6 = new Vector.<int>();
         this.FCustomImageVec7 = new Vector.<int>();
         this.FCustomImageVec8 = new Vector.<int>();
         this.FCustomImageVec9 = new Vector.<int>();
         this.FCustomImageName1 = new Vector.<String>();
         this.FCustomImageName2 = new Vector.<String>();
         this.FCustomImageName3 = new Vector.<String>();
         this.FCustomImageName4 = new Vector.<String>();
         this.FCustomImageName5 = new Vector.<String>();
         this.FCustomImageName6 = new Vector.<String>();
         this.FCustomImageName7 = new Vector.<String>();
         this.FCustomImageName8 = new Vector.<String>();
         this.FCustomImageName9 = new Vector.<String>();
         this.FSixSamsaraAttribute = new Array();
         this.FSixSamsaraNextAttribute = new Array();
         this.FSixSamsaraAttributeDescribe = new Array();
         this.FAllCustomDropReward1 = new Array();
         this.FAllCustomDropReward2 = new Array();
         this.FAllCustomDropReward3 = new Array();
         this.FAllCustomDropReward4 = new Array();
         this.FAllCustomDropReward5 = new Array();
         this.FAllCustomDropReward6 = new Array();
         this.FAllCustomDropReward7 = new Array();
         this.FAllCustomDropReward8 = new Array();
         this.FAllCustomDropReward9 = new Array();
         this.FCurCustomDropReward = new Vector.<TFixedAward>();
         this.FAutoBtnIsCanClcik = new Vector.<uint>();
      }
      
      public function initilizationData() : void
      {
         var _loc1_:TRebirth = null;
         var _loc2_:TRebirth_battle = null;
         var _loc3_:int = 0;
         this.FRebirth = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Rebirth);
         this.FRebirth_battle = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Rebirth_battle);
         this.FAllCustomNum = this.FRebirth_battle.Count;
         _loc3_ = 0;
         while(_loc3_ < this.FAllCustomNum)
         {
            _loc2_ = this.FRebirth_battle.GetDatebaseByIndex(_loc3_) as TRebirth_battle;
            switch(_loc2_.Location)
            {
               case 1:
                  this.FCustomImageVec1.push(_loc2_.Image);
                  this.FCustomImageName1.push(_loc2_.BossName);
                  this.FAllCustomDropReward1.push(_loc2_.Awards);
                  this.FCommonCustomRecommendPower = _loc2_.RecommendPower;
                  break;
               case 2:
                  this.FCustomImageVec2.push(_loc2_.Image);
                  this.FCustomImageName2.push(_loc2_.BossName);
                  this.FAllCustomDropReward2.push(_loc2_.Awards);
                  this.FDifficultyCustomRecommendPower = _loc2_.RecommendPower;
                  break;
               case 3:
                  this.FCustomImageVec3.push(_loc2_.Image);
                  this.FCustomImageName3.push(_loc2_.BossName);
                  this.FAllCustomDropReward3.push(_loc2_.Awards);
                  this.FHellCustomRecommendPower = _loc2_.RecommendPower;
                  break;
               case 4:
                  this.FCustomImageVec4.push(_loc2_.Image);
                  this.FCustomImageName4.push(_loc2_.BossName);
                  this.FAllCustomDropReward4.push(_loc2_.Awards);
                  this.FCommonCustomRecommendPower2 = _loc2_.RecommendPower;
                  break;
               case 5:
                  this.FCustomImageVec5.push(_loc2_.Image);
                  this.FCustomImageName5.push(_loc2_.BossName);
                  this.FAllCustomDropReward5.push(_loc2_.Awards);
                  this.FDifficultyCustomRecommendPower2 = _loc2_.RecommendPower;
                  break;
               case 6:
                  this.FCustomImageVec6.push(_loc2_.Image);
                  this.FCustomImageName6.push(_loc2_.BossName);
                  this.FAllCustomDropReward6.push(_loc2_.Awards);
                  this.FHellCustomRecommendPower2 = _loc2_.RecommendPower;
                  break;
               case 7:
                  this.FCustomImageVec7.push(_loc2_.Image);
                  this.FCustomImageName7.push(_loc2_.BossName);
                  this.FAllCustomDropReward7.push(_loc2_.Awards);
                  this.FCommonCustomRecommendPower3 = _loc2_.RecommendPower;
                  break;
               case 8:
                  this.FCustomImageVec8.push(_loc2_.Image);
                  this.FCustomImageName8.push(_loc2_.BossName);
                  this.FAllCustomDropReward8.push(_loc2_.Awards);
                  this.FDifficultyCustomRecommendPower3 = _loc2_.RecommendPower;
                  break;
               case 9:
                  this.FCustomImageVec9.push(_loc2_.Image);
                  this.FCustomImageName9.push(_loc2_.BossName);
                  this.FAllCustomDropReward9.push(_loc2_.Awards);
                  this.FHellCustomRecommendPower3 = _loc2_.RecommendPower;
            }
            _loc3_++;
         }
         if(this.FRebirth.Count)
         {
            _loc1_ = this.FRebirth.GetDatebaseByIndex(0) as TRebirth;
            this.FSixSamsaraAttributeDescribe = _loc1_.AddProperty;
         }
      }
      
      public function set todayChallengeType(param1:int) : void
      {
         this.FtodayChallengeType = param1;
      }
      
      public function get todayChallengeType() : int
      {
         return this.FtodayChallengeType;
      }
      
      public function set AssisttodayChallengeType(param1:int) : void
      {
         this.FAssisttodayChallengeType = param1;
      }
      
      public function get AssisttodayChallengeType() : int
      {
         return this.FAssisttodayChallengeType;
      }
      
      public function set CurCustomId(param1:int) : void
      {
         var _loc2_:TRebirth_battle = null;
         this.FCurCustomId = param1;
         if(!this.FRebirth_battle)
         {
            return;
         }
         if(this.FCurCustomId == 0)
         {
            _loc2_ = this.FRebirth_battle.GetDatebaseByIndex(0) as TRebirth_battle;
            this.FCurCustomBig = 0;
            this.FCurCustomLittle = 0;
            this.FNextCustomBig = _loc2_.Location;
            this.FNextCustomLittle = _loc2_.SStage;
         }
         else
         {
            _loc2_ = this.FRebirth_battle.GetDatebaseByIdentifier(this.FCurCustomId) as TRebirth_battle;
            this.FCurCustomBig = _loc2_.Location;
            this.FCurCustomLittle = _loc2_.SStage;
            ++this.FCurCustomId;
            _loc2_ = this.FRebirth_battle.GetDatebaseByIdentifier(this.FCurCustomId) as TRebirth_battle;
            if(_loc2_)
            {
               this.FNextCustomBig = _loc2_.Location;
               this.FNextCustomLittle = _loc2_.SStage;
            }
            else
            {
               this.FNextCustomBig = 0;
               this.FNextCustomLittle = 0;
               this.FIsPassCustom = true;
            }
         }
      }
      
      public function get CurCustomId() : int
      {
         return this.FCurCustomId;
      }
      
      public function set SixSamsaraId(param1:int) : void
      {
         var _loc2_:TRebirth = null;
         this.FSixSamsaraId = param1;
         if(this.FRebirth == null)
         {
            this.FRebirth = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Rebirth);
         }
         if(this.FSixSamsaraId == 0)
         {
            this.FSixSamsaraName = STRING_COMMON.SixFary_NameSpecial_Show;
            _loc2_ = this.FRebirth.GetDatebaseByIndex(0) as TRebirth;
            this.FSixSamsaraStuffNum = _loc2_.Num;
            this.FSixSamsaraAttribute.length = 0;
            this.FSixSamsaraNextAttribute = _loc2_.AddProperty;
            this.FSixSamsaraLevel = 0;
         }
         else
         {
            _loc2_ = this.FRebirth.GetDatebaseByIdentifier(this.FSixSamsaraId) as TRebirth;
            this.FSixSamsaraName = _loc2_.Name;
            this.FSixSamsaraLevel = _loc2_.Level;
            this.FSixSamsaraAttribute = _loc2_.AddProperty;
            this.FSixSamsaraId = _loc2_.Nextid;
            _loc2_ = this.FRebirth.GetDatebaseByIdentifier(this.FSixSamsaraId) as TRebirth;
            if(_loc2_)
            {
               this.FSixSamsaraNextAttribute = _loc2_.AddProperty;
               this.FSixSamsaraStuffNum = _loc2_.Num;
            }
            else
            {
               this.FSixSamsaraNextAttribute.length = 0;
               this.FSixSamsaraStuffNum = 0;
               this.FSixSamsaraIsOver = true;
            }
         }
      }
      
      public function get SixSamsaraId() : int
      {
         return this.FSixSamsaraId;
      }
      
      public function get SixSamsaraLevel() : int
      {
         return this.FSixSamsaraLevel;
      }
      
      public function get SixSamsaraIsOver() : Boolean
      {
         return this.FSixSamsaraIsOver;
      }
      
      public function set SixSamsaraStuffId(param1:int) : void
      {
         this.FSixSamsaraStuffId = param1;
      }
      
      public function get SixSamsaraStuffId() : int
      {
         return this.FSixSamsaraStuffId;
      }
      
      public function get SixSamsaraStuffNum() : int
      {
         return this.FSixSamsaraStuffNum;
      }
      
      public function get SixSamsaraName() : String
      {
         return this.FSixSamsaraName;
      }
      
      public function get SixSamsaraAttribute() : Array
      {
         return this.FSixSamsaraAttribute;
      }
      
      public function get SixSamsaraAttributeDescribe() : Array
      {
         return this.FSixSamsaraAttributeDescribe;
      }
      
      public function get SixSamsaraNextAttribute() : Array
      {
         return this.FSixSamsaraNextAttribute;
      }
      
      public function get CommonCustomRecommendPower() : int
      {
         return this.FCommonCustomRecommendPower;
      }
      
      public function get DifficultyCustomRecommendPower() : int
      {
         return this.FDifficultyCustomRecommendPower;
      }
      
      public function get HellCustomRecommendPower() : int
      {
         return this.FHellCustomRecommendPower;
      }
      
      public function get CommonCustomRecommendPower2() : int
      {
         return this.FCommonCustomRecommendPower2;
      }
      
      public function get DifficultyCustomRecommendPower2() : int
      {
         return this.FDifficultyCustomRecommendPower2;
      }
      
      public function get HellCustomRecommendPower2() : int
      {
         return this.FHellCustomRecommendPower2;
      }
      
      public function get CommonCustomRecommendPower3() : int
      {
         return this.FCommonCustomRecommendPower3;
      }
      
      public function get DifficultyCustomRecommendPower3() : int
      {
         return this.FDifficultyCustomRecommendPower3;
      }
      
      public function get HellCustomRecommendPower3() : int
      {
         return this.FHellCustomRecommendPower3;
      }
      
      public function get CurCustomDropReward() : Vector.<TFixedAward>
      {
         return this.FCurCustomDropReward;
      }
      
      public function get AllCustomDropReward1() : Array
      {
         return this.FAllCustomDropReward1;
      }
      
      public function get AllCustomDropReward2() : Array
      {
         return this.FAllCustomDropReward2;
      }
      
      public function get AllCustomDropReward3() : Array
      {
         return this.FAllCustomDropReward3;
      }
      
      public function get AllCustomDropReward4() : Array
      {
         return this.FAllCustomDropReward4;
      }
      
      public function get AllCustomDropReward5() : Array
      {
         return this.FAllCustomDropReward5;
      }
      
      public function get AllCustomDropReward6() : Array
      {
         return this.FAllCustomDropReward6;
      }
      
      public function get IsPassCustom() : Boolean
      {
         return this.FIsPassCustom;
      }
      
      public function get CurCustomBig() : int
      {
         return this.FCurCustomBig;
      }
      
      public function get CurCustomLittle() : int
      {
         return this.FCurCustomLittle;
      }
      
      public function get NextCustomBig() : int
      {
         return this.FNextCustomBig;
      }
      
      public function get NextCustomLittle() : int
      {
         return this.FNextCustomLittle;
      }
      
      public function get AllCustomNum() : int
      {
         return this.FAllCustomNum;
      }
      
      public function set TodayChallengeTimes(param1:int) : void
      {
         this.FTodayChallengeTimes = param1;
      }
      
      public function get TodayChallengeTimes() : int
      {
         return this.FTodayChallengeTimes;
      }
      
      public function set TurntableTurnTimes(param1:int) : void
      {
         this.FTurntableTurnTimes = param1;
      }
      
      public function get TurntableTurnTimes() : int
      {
         return this.FTurntableTurnTimes;
      }
      
      public function set AddAttributeVec1_Obj(param1:Vector.<Object>) : void
      {
         this.FAddAttributeVec1_Obj = param1;
      }
      
      public function get AddAttributeVec1_Obj() : Vector.<Object>
      {
         return this.FAddAttributeVec1_Obj;
      }
      
      public function set AddAttributeVec2_Obj(param1:Vector.<Object>) : void
      {
         this.FAddAttributeVec2_Obj = param1;
      }
      
      public function get AddAttributeVec2_Obj() : Vector.<Object>
      {
         return this.FAddAttributeVec2_Obj;
      }
      
      public function set AttribNum(param1:Number) : void
      {
         this.FAttribNum = param1;
      }
      
      public function get AttribNum() : Number
      {
         return this.FAttribNum;
      }
      
      public function set AttribType(param1:int) : void
      {
         this.FAttribType = param1;
      }
      
      public function get AttribType() : int
      {
         return this.FAttribType;
      }
      
      public function get CustomImageVec() : Vector.<int>
      {
         var _loc1_:Vector.<int> = null;
         switch(this.FAssisttodayChallengeType)
         {
            case 0:
            case 1:
               _loc1_ = this.FCustomImageVec1;
               break;
            case 2:
               _loc1_ = this.FCustomImageVec2;
               break;
            case 3:
               _loc1_ = this.FCustomImageVec3;
               break;
            case 4:
               _loc1_ = this.FCustomImageVec4;
               break;
            case 5:
               _loc1_ = this.FCustomImageVec5;
               break;
            case 6:
               _loc1_ = this.FCustomImageVec6;
               break;
            case 7:
               _loc1_ = this.FCustomImageVec7;
               break;
            case 8:
               _loc1_ = this.FCustomImageVec8;
               break;
            case 9:
               _loc1_ = this.FCustomImageVec9;
         }
         return _loc1_;
      }
      
      public function get CustomImageName() : Vector.<String>
      {
         var _loc1_:Vector.<String> = null;
         switch(this.FAssisttodayChallengeType)
         {
            case 0:
            case 1:
               _loc1_ = this.FCustomImageName1;
               break;
            case 2:
               _loc1_ = this.FCustomImageName2;
               break;
            case 3:
               _loc1_ = this.FCustomImageName3;
               break;
            case 4:
               _loc1_ = this.FCustomImageName4;
               break;
            case 5:
               _loc1_ = this.FCustomImageName5;
               break;
            case 6:
               _loc1_ = this.FCustomImageName6;
               break;
            case 7:
               _loc1_ = this.FCustomImageName7;
               break;
            case 8:
               _loc1_ = this.FCustomImageName8;
               break;
            case 9:
               _loc1_ = this.FCustomImageName9;
         }
         return _loc1_;
      }
      
      public function set TurntableIsCanMove(param1:Boolean) : void
      {
         this.FTurntableIsCanMove = param1;
      }
      
      public function get TurntableIsCanMove() : Boolean
      {
         return this.FTurntableIsCanMove;
      }
      
      public function get AutoBtnIsCanClcik() : Vector.<uint>
      {
         return this.FAutoBtnIsCanClcik;
      }
      
      public function get AutoFireGetRewardCount() : uint
      {
         return this.FAutoFireGetRewardCount;
      }
      
      public function set AutoFireGetRewardCount(param1:uint) : void
      {
         this.FAutoFireGetRewardCount = param1;
      }
   }
}

