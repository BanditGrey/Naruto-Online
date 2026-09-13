package Logics.Pet
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Logics.DatebaseVO.VO.TBasePet;
   import Logics.DatebaseVO.VO.TSoulArray;
   import Logics.Exercise.TBaseActivity;
   import Resources.Constants.CONST_DATEBASEVO;
   
   public class TPet
   {
      
      protected var FPetID:int;
      
      protected var FImageID:int;
      
      protected var FPetImageID:int;
      
      protected var FSoulID:int;
      
      protected var FCurrentExp:int;
      
      protected var FCurrentSoulExp:int;
      
      protected var FSmallIcon:int;
      
      protected var FMiddleIcon:int;
      
      protected var FPetBigImageID:int;
      
      protected var FPetModelID:int;
      
      protected var FName:String;
      
      protected var FMonsterID:int;
      
      protected var FReviceCount:int;
      
      protected var FStar:int;
      
      protected var FCanRevive:int;
      
      protected var FLevelLimit:int;
      
      protected var FNormalExp:int;
      
      protected var FGoldExp:int;
      
      protected var FNeedExp:int;
      
      protected var FGainExp:int;
      
      protected var FReincarnationLevel:int;
      
      protected var FNextReincarnationLevel:int;
      
      protected var FPower:int;
      
      protected var FAgile:int;
      
      protected var FIntelligence:int;
      
      protected var FLife:int;
      
      protected var FImages:Vector.<uint>;
      
      protected var FAddRate:Number;
      
      protected var FDesc:String;
      
      protected var FLockDesc:String;
      
      protected var FSmallCritCount:uint;
      
      protected var FBigCritCount:uint;
      
      protected var FRelexBoo:Boolean;
      
      protected var FAddType:uint;
      
      protected var FAddValue:uint;
      
      protected var FMonsterLevel:int;
      
      protected var FMonsterNextAddValue:uint;
      
      protected var FMonsterCurrentAddValue:uint;
      
      protected var FTrainTimes:uint;
      
      protected var FPetBin:TBins;
      
      public var SoulFormations:Vector.<TSoulArray>;
      
      public var AddSoulFormation:TSoulArray;
      
      public var AddSoul:TAddSoul;
      
      public var CurSoulFormationID:int;
      
      public var UnlockPetIds:Vector.<int>;
      
      public function TPet()
      {
         super();
         this.FImages = new Vector.<uint>();
         this.SoulFormations = new Vector.<TSoulArray>();
         this.AddSoul = new TAddSoul();
         this.UnlockPetIds = new Vector.<int>();
         this.FPetBin = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_BasePet);
      }
      
      public function get PetID() : int
      {
         return this.FPetID;
      }
      
      public function set PetID(param1:int) : void
      {
         this.FPetID = param1;
      }
      
      public function get SoulID() : int
      {
         return this.FSoulID;
      }
      
      public function set SoulID(param1:int) : void
      {
         this.FSoulID = param1;
      }
      
      public function get MonsterID() : int
      {
         return this.FMonsterID;
      }
      
      public function set MonsterID(param1:int) : void
      {
         this.FMonsterID = param1;
      }
      
      public function get PetBigImageID() : int
      {
         return this.FPetBigImageID;
      }
      
      public function set PetBigImageID(param1:int) : void
      {
         this.FPetBigImageID = param1;
      }
      
      public function get PetModelID() : int
      {
         return this.FPetModelID;
      }
      
      public function set PetModelID(param1:int) : void
      {
         this.FPetModelID = param1;
      }
      
      public function get ImageID() : int
      {
         return this.FImageID;
      }
      
      public function set ImageID(param1:int) : void
      {
         this.FImageID = param1;
      }
      
      public function get PetImageID() : int
      {
         return this.FPetImageID;
      }
      
      public function set PetImageID(param1:int) : void
      {
         this.FPetImageID = param1;
      }
      
      public function get SmallIcon() : int
      {
         return this.FSmallIcon;
      }
      
      public function set SmallIcon(param1:int) : void
      {
         this.FSmallIcon = param1;
      }
      
      public function get MiddleIcon() : int
      {
         return this.FMiddleIcon;
      }
      
      public function set MiddleIcon(param1:int) : void
      {
         this.FMiddleIcon = param1;
      }
      
      public function get ReviceCount() : int
      {
         return this.FReviceCount;
      }
      
      public function set ReviceCount(param1:int) : void
      {
         this.FReviceCount = param1;
      }
      
      public function get MonsterLevel() : int
      {
         return this.FMonsterLevel;
      }
      
      public function set MonsterLevel(param1:int) : void
      {
         this.FMonsterLevel = param1;
      }
      
      public function get Star() : int
      {
         return this.FStar;
      }
      
      public function set Star(param1:int) : void
      {
         this.FStar = param1;
      }
      
      public function get CanRevive() : int
      {
         return this.FCanRevive;
      }
      
      public function set CanRevive(param1:int) : void
      {
         this.FCanRevive = param1;
      }
      
      public function get LevelLimit() : int
      {
         return this.FLevelLimit;
      }
      
      public function set LevelLimit(param1:int) : void
      {
         this.FLevelLimit = param1;
      }
      
      public function get NormalExp() : int
      {
         return this.FNormalExp;
      }
      
      public function set NormalExp(param1:int) : void
      {
         this.FNormalExp = param1;
      }
      
      public function get GoldExp() : int
      {
         return this.FGoldExp;
      }
      
      public function set GoldExp(param1:int) : void
      {
         this.FGoldExp = param1;
      }
      
      public function get NeedExp() : int
      {
         return this.FNeedExp;
      }
      
      public function set NeedExp(param1:int) : void
      {
         this.FNeedExp = param1;
      }
      
      public function get GainExp() : int
      {
         return this.FGainExp;
      }
      
      public function set GainExp(param1:int) : void
      {
         this.FGainExp = param1;
      }
      
      public function get ReincarnationLevel() : int
      {
         return this.FReincarnationLevel;
      }
      
      public function set ReincarnationLevel(param1:int) : void
      {
         this.FReincarnationLevel = param1;
      }
      
      public function get NextReincarnationLevel() : int
      {
         return this.FNextReincarnationLevel;
      }
      
      public function set NextReincarnationLevel(param1:int) : void
      {
         this.FNextReincarnationLevel = param1;
      }
      
      public function get CurrentExp() : int
      {
         return this.FCurrentExp;
      }
      
      public function set CurrentExp(param1:int) : void
      {
         this.FCurrentExp = param1;
      }
      
      public function get CurrentSoulExp() : int
      {
         return this.FCurrentSoulExp;
      }
      
      public function set CurrentSoulExp(param1:int) : void
      {
         this.FCurrentSoulExp = param1;
      }
      
      public function get Power() : int
      {
         return this.FPower;
      }
      
      public function set Power(param1:int) : void
      {
         this.FPower = param1;
      }
      
      public function get Agile() : int
      {
         return this.FAgile;
      }
      
      public function set Agile(param1:int) : void
      {
         this.FAgile = param1;
      }
      
      public function get Intelligence() : int
      {
         return this.FIntelligence;
      }
      
      public function set Intelligence(param1:int) : void
      {
         this.FIntelligence = param1;
      }
      
      public function get Life() : int
      {
         return this.FLife;
      }
      
      public function set Life(param1:int) : void
      {
         this.FLife = param1;
      }
      
      public function get Images() : Vector.<uint>
      {
         return this.FImages;
      }
      
      public function set Images(param1:Vector.<uint>) : void
      {
         this.FImages = param1;
      }
      
      public function get AddRate() : Number
      {
         return this.FAddRate;
      }
      
      public function set AddRate(param1:Number) : void
      {
         this.FAddRate = param1;
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function set Name(param1:String) : void
      {
         this.FName = param1;
      }
      
      public function get Desc() : String
      {
         return this.FDesc;
      }
      
      public function set Desc(param1:String) : void
      {
         this.FDesc = param1;
      }
      
      public function get LockDesc() : String
      {
         return this.FLockDesc;
      }
      
      public function set LockDesc(param1:String) : void
      {
         this.FLockDesc = param1;
      }
      
      public function get SmallCritCount() : uint
      {
         return this.FSmallCritCount;
      }
      
      public function set SmallCritCount(param1:uint) : void
      {
         this.FSmallCritCount = param1;
      }
      
      public function get BigCritCount() : uint
      {
         return this.FBigCritCount;
      }
      
      public function set BigCritCount(param1:uint) : void
      {
         this.FBigCritCount = param1;
      }
      
      public function get AddType() : uint
      {
         return this.FAddType;
      }
      
      public function set AddType(param1:uint) : void
      {
         this.FAddType = param1;
      }
      
      public function get AddValue() : uint
      {
         return this.FAddValue;
      }
      
      public function set AddValue(param1:uint) : void
      {
         this.FAddValue = param1;
      }
      
      public function get MonsterNextAddValue() : uint
      {
         return this.FMonsterNextAddValue;
      }
      
      public function set MonsterNextAddValue(param1:uint) : void
      {
         this.FMonsterNextAddValue = param1;
      }
      
      public function get MonsterCurrentAddValue() : uint
      {
         return this.FMonsterCurrentAddValue;
      }
      
      public function set MonsterCurrentAddValue(param1:uint) : void
      {
         this.FMonsterCurrentAddValue = param1;
      }
      
      public function get RelexBoo() : Boolean
      {
         return this.FRelexBoo;
      }
      
      public function set RelexBoo(param1:Boolean) : void
      {
         this.FRelexBoo = param1;
      }
      
      public function get TrainTimes() : uint
      {
         return this.FTrainTimes;
      }
      
      public function set TrainTimes(param1:uint) : void
      {
         this.FTrainTimes = param1;
      }
      
      public function GetSoulFormationByIdentify(param1:int) : TSoulArray
      {
         var _loc2_:int = 0;
         var _loc3_:TSoulArray = null;
         _loc2_ = 0;
         while(_loc2_ < this.SoulFormations.length)
         {
            _loc3_ = this.SoulFormations[_loc2_];
            if(_loc3_.Identifier == param1)
            {
               return _loc3_;
            }
            _loc2_++;
         }
         return null;
      }
      
      public function GetSoulFormationIndexByIdentify(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc3_:TSoulArray = null;
         _loc2_ = 0;
         while(_loc2_ < this.SoulFormations.length)
         {
            _loc3_ = this.SoulFormations[_loc2_];
            if(_loc3_.Identifier == param1)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
      
      public function ActiveSoulFormation(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TSoulArray = null;
         _loc3_ = this.GetSoulFormationByIdentify(param1);
         _loc3_.Status = TBaseActivity.STATUS_GETED;
      }
      
      public function OpenSoulFormation(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TSoulArray = null;
         _loc2_ = 0;
         while(_loc2_ < this.SoulFormations.length)
         {
            _loc3_ = this.SoulFormations[_loc2_];
            if(_loc3_.Identifier == param1)
            {
               _loc3_.Status = TBaseActivity.STATUS_IS_GOT;
               this.CurSoulFormationID = param1;
            }
            else if(_loc3_.Status == TBaseActivity.STATUS_IS_GOT)
            {
               _loc3_.Status = TBaseActivity.STATUS_GETED;
            }
            _loc2_++;
         }
      }
      
      public function IsUnlock(param1:int) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:Boolean = false;
         _loc3_ = this.UnlockPetIds.indexOf(param1);
         return _loc3_ > -1;
      }
      
      public function get IsPetNewType() : Boolean
      {
         var _loc2_:TBasePet = null;
         var _loc1_:Boolean = false;
         _loc2_ = this.FPetBin.GetDatebaseByIdentifier(this.PetID) as TBasePet;
         if(Boolean(_loc2_) && _loc2_.ItemArr.length > 0)
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
   }
}

