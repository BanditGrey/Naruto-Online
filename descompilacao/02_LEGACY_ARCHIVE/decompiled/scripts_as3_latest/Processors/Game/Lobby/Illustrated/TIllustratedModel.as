package Processors.Game.Lobby.Illustrated
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Logics.Characters.TCharacter;
   import Logics.DatebaseVO.VO.TArchive;
   import Logics.DatebaseVO.VO.TArchiveUpgrade;
   import Logics.Illustrated.TIllustrated;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_COMMON;
   import flash.filters.ColorMatrixFilter;
   
   public class TIllustratedModel
   {
      
      protected static var FSystemLanguage:TBins;
      
      protected static var FArchive:TBins;
      
      protected static var FArchiveUpgrade:TBins;
      
      protected static var FArchiveCofig:TBins;
      
      protected static var FArchiveSuper:TBins;
      
      protected static var FPsychics:TBins;
      
      protected static var FResolveEquips:Vector.<Object>;
      
      protected static var FSuits:Vector.<TArchive>;
      
      protected static var FAccessorys:Vector.<TArchive>;
      
      protected static var FPsychicBeasts:Vector.<TArchive>;
      
      protected static var FTitles:Vector.<TArchive>;
      
      protected static var FNarutos:Vector.<TArchive>;
      
      protected static var FWings:Vector.<TArchive>;
      
      public static var FIllustrated:TIllustrated;
      
      public static var FCharacter:TCharacter;
      
      public static var FSelecteds:Vector.<String>;
      
      public static const REG_EXP:RegExp = /\%(\d+)/;
      
      public static const ADD_ATTRIBUTE:Array = [[18,23,21,22,13,4],[17,22,21,19,9,28],[10,14,22,20,21,28]];
      
      public static const GRAY_FILTER:ColorMatrixFilter = new ColorMatrixFilter([0.3,0.6,0,0,0,0.3,0.6,0,0,0,0.3,0.6,0,0,0,0,0,0,1,0]);
      
      public function TIllustratedModel()
      {
         super();
      }
      
      public static function get SystemLanguage() : TBins
      {
         if(FSystemLanguage == null)
         {
            FSystemLanguage = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_SystemLanguage);
         }
         return FSystemLanguage;
      }
      
      public static function get Archive() : TBins
      {
         if(FArchive == null)
         {
            FArchive = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Archive);
         }
         return FArchive;
      }
      
      public static function get ArchiveUpgrade() : TBins
      {
         if(FArchiveUpgrade == null)
         {
            FArchiveUpgrade = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_ArchiveUpgrade);
         }
         return FArchiveUpgrade;
      }
      
      public static function get ArchiveCofig() : TBins
      {
         if(FArchiveCofig == null)
         {
            FArchiveCofig = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_ArchiveCofig);
         }
         return FArchiveCofig;
      }
      
      public static function get ArchiveSuper() : TBins
      {
         if(FArchiveSuper == null)
         {
            FArchiveSuper = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_ArchiveSuper);
         }
         return FArchiveSuper;
      }
      
      public static function get Psychics() : TBins
      {
         if(FPsychics == null)
         {
            FPsychics = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_BB_Status);
         }
         return FPsychics;
      }
      
      public static function get ResolveEquips() : Vector.<Object>
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Object = null;
         if(FResolveEquips == null)
         {
            FResolveEquips = new Vector.<Object>();
            _loc1_ = Archive.Count;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               _loc3_ = {};
               _loc3_.SuitId = Archive.GetDatebaseByIndex(_loc2_)["SuitIdVector"];
               _loc3_.Resolve = Archive.GetDatebaseByIndex(_loc2_)["Resolve"];
               FResolveEquips.push(_loc3_);
               _loc2_++;
            }
         }
         return FResolveEquips;
      }
      
      public static function ResolveCount(param1:int) : int
      {
         var _loc2_:int = int(ResolveEquips.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if(ResolveEquips[_loc3_].SuitId.indexOf(param1) != -1)
            {
               return ResolveEquips[_loc3_].Resolve;
            }
            _loc3_++;
         }
         return 0;
      }
      
      public static function Sort(param1:Vector.<TArchive>) : Vector.<TArchive>
      {
         var _loc5_:Array = null;
         var _loc6_:int = 0;
         var _loc2_:Array = [];
         var _loc3_:int = int(param1.length);
         var _loc4_:* = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = ActivationData(param1[_loc4_]);
            if(_loc2_[_loc5_.length] == null)
            {
               _loc2_[_loc5_.length] = [];
            }
            _loc2_[_loc5_.length].push(param1[_loc4_]);
            _loc4_++;
         }
         param1 = new Vector.<TArchive>();
         _loc4_ = int(_loc2_.length - 1);
         while(_loc4_ >= 0)
         {
            if(Boolean(_loc2_[_loc4_]) && _loc2_[_loc4_] is Array)
            {
               _loc6_ = 0;
               while(_loc6_ < _loc2_[_loc4_].length)
               {
                  param1.push(_loc2_[_loc4_][_loc6_]);
                  _loc6_++;
               }
            }
            _loc4_--;
         }
         return param1;
      }
      
      public static function get Suits() : Vector.<TArchive>
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TArchive = null;
         if(FSuits == null)
         {
            FSuits = new Vector.<TArchive>();
            _loc1_ = Archive.Count;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               _loc3_ = Archive.GetDatebaseByIndex(_loc2_) as TArchive;
               if(_loc3_.Type == 1)
               {
                  FSuits.push(_loc3_);
               }
               _loc2_++;
            }
         }
         return FSuits;
      }
      
      public static function set Suits(param1:Vector.<TArchive>) : void
      {
         FSuits = param1;
      }
      
      public static function get Accessorys() : Vector.<TArchive>
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TArchive = null;
         if(FAccessorys == null)
         {
            FAccessorys = new Vector.<TArchive>();
            _loc1_ = Archive.Count;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               _loc3_ = Archive.GetDatebaseByIndex(_loc2_) as TArchive;
               if(_loc3_.Type == 2)
               {
                  FAccessorys.push(_loc3_);
               }
               _loc2_++;
            }
         }
         return FAccessorys;
      }
      
      public static function set Accessorys(param1:Vector.<TArchive>) : void
      {
         FAccessorys = param1;
      }
      
      public static function get PsychicBeasts() : Vector.<TArchive>
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TArchive = null;
         if(FPsychicBeasts == null)
         {
            FPsychicBeasts = new Vector.<TArchive>();
            _loc1_ = Archive.Count;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               _loc3_ = Archive.GetDatebaseByIndex(_loc2_) as TArchive;
               if(_loc3_.Type == 3)
               {
                  FPsychicBeasts.push(_loc3_);
               }
               _loc2_++;
            }
         }
         return FPsychicBeasts;
      }
      
      public static function set PsychicBeasts(param1:Vector.<TArchive>) : void
      {
         FPsychicBeasts = param1;
      }
      
      public static function get Titles() : Vector.<TArchive>
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TArchive = null;
         if(FTitles == null)
         {
            FTitles = new Vector.<TArchive>();
            _loc1_ = Archive.Count;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               _loc3_ = Archive.GetDatebaseByIndex(_loc2_) as TArchive;
               if(_loc3_.Type == 4)
               {
                  FTitles.push(_loc3_);
               }
               _loc2_++;
            }
         }
         return FTitles;
      }
      
      public static function set Titles(param1:Vector.<TArchive>) : void
      {
         FTitles = param1;
      }
      
      public static function get Narutos() : Vector.<TArchive>
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TArchive = null;
         if(FNarutos == null)
         {
            FNarutos = new Vector.<TArchive>();
            _loc1_ = Archive.Count;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               _loc3_ = Archive.GetDatebaseByIndex(_loc2_) as TArchive;
               if(_loc3_.Type == 5)
               {
                  FNarutos.push(_loc3_);
               }
               _loc2_++;
            }
         }
         return FNarutos;
      }
      
      public static function set Narutos(param1:Vector.<TArchive>) : void
      {
         FNarutos = param1;
      }
      
      public static function get Wings() : Vector.<TArchive>
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TArchive = null;
         if(FWings == null)
         {
            FWings = new Vector.<TArchive>();
            _loc1_ = Archive.Count;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               _loc3_ = Archive.GetDatebaseByIndex(_loc2_) as TArchive;
               if(_loc3_.Type == 6)
               {
                  FWings.push(_loc3_);
               }
               _loc2_++;
            }
         }
         return FWings;
      }
      
      public static function set Wings(param1:Vector.<TArchive>) : void
      {
         FWings = param1;
      }
      
      public static function get Selecteds() : Vector.<String>
      {
         if(FSelecteds == null)
         {
            FSelecteds = new Vector.<String>();
         }
         return FSelecteds;
      }
      
      public static function ClearSelecteds() : void
      {
         Selecteds.length = 0;
      }
      
      public static function ChangeSelecteds(param1:String) : void
      {
         var _loc2_:int = Selecteds.indexOf(param1);
         if(_loc2_ == -1)
         {
            Selecteds.push(param1);
         }
         else
         {
            Selecteds.splice(_loc2_,1);
         }
      }
      
      public static function TextFormat(param1:int, ... rest) : String
      {
         var _loc4_:int = 0;
         if(SystemLanguage.GetDatebaseByIdentifier(param1) == null)
         {
            return "";
         }
         var _loc3_:String = SystemLanguage.GetDatebaseByIdentifier(param1)["Desc"];
         if(_loc3_)
         {
            if(Boolean(rest) && rest.length > 0)
            {
               _loc4_ = 0;
               while(_loc4_ < rest.length)
               {
                  _loc3_ = _loc3_.replace(REG_EXP,rest[_loc4_]);
                  _loc4_++;
               }
               return _loc3_;
            }
            return _loc3_;
         }
         return "";
      }
      
      public static function AttributeFormat(param1:int, param2:Number, param3:Boolean = true) : String
      {
         var _loc4_:int = CONST_COMMON.BASEATTRIBUTENAMES.indexOf(param1);
         var _loc5_:String = STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[_loc4_];
         if(param2 != 0)
         {
            if(param2 > 1)
            {
               return _loc5_ + (param3 ? " +" : " ") + param2;
            }
            return _loc5_ + (param3 ? " +" : " ") + (param2 * 100).toFixed(0) + "%";
         }
         return _loc5_;
      }
      
      public static function IllustratedLevel(param1:int) : Object
      {
         var _loc5_:TArchiveUpgrade = null;
         var _loc2_:Object = {};
         var _loc3_:int = ArchiveUpgrade.Count;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = ArchiveUpgrade.GetDatebaseByIndex(_loc4_) as TArchiveUpgrade;
            if(param1 < _loc5_.AllExp)
            {
               break;
            }
            _loc2_.Level = _loc5_.Level;
            _loc2_.Exp = Math.max(0,param1 - _loc5_.AllExp);
            _loc2_.MaxExp = _loc5_.NeedExp;
            _loc4_++;
         }
         return _loc2_;
      }
      
      public static function IllustratedAddAttribute(param1:int) : Array
      {
         var _loc4_:TArchive = null;
         var _loc2_:int = Archive.Count;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = Archive.GetDatebaseByIndex(_loc3_) as TArchive;
            if(_loc4_.Identifier == param1)
            {
               return _loc4_.AddAttributeVector[0];
            }
            _loc3_++;
         }
         return null;
      }
      
      public static function MergeEquipID(param1:Object) : String
      {
         return param1.Identifier0 + "" + param1.Identifier1;
      }
      
      public static function MergeAddAttribute(param1:Array, param2:Array) : Array
      {
         var _loc3_:Array = null;
         for each(_loc3_ in param1)
         {
            if(_loc3_[0] == param2[0])
            {
               _loc3_[1] += param2[1];
               return param1;
            }
         }
         param1.push([param2[0],param2[1]]);
         return param1;
      }
      
      public static function IllustratedType(param1:int) : int
      {
         var _loc4_:TArchive = null;
         var _loc2_:int = Archive.Count;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = Archive.GetDatebaseByIndex(_loc3_) as TArchive;
            if(_loc4_.Identifier == param1)
            {
               return _loc4_.Type;
            }
            _loc3_++;
         }
         return -1;
      }
      
      public static function ActivationData(param1:TArchive) : Array
      {
         var _loc2_:Array = FIllustrated.IllustratedInfo;
         var _loc3_:int = int(_loc2_.length);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            if(_loc2_[_loc4_].ID == param1.Identifier)
            {
               return _loc2_[_loc4_].Parts;
            }
            _loc4_++;
         }
         return [];
      }
      
      public static function ActivationAddAttribute(param1:int) : Array
      {
         var _loc2_:Array = [];
         var _loc3_:Array = FIllustrated.IllustratedInfo;
         var _loc4_:int = int(_loc3_.length);
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            if(_loc3_[_loc5_].Type == param1)
            {
               if(_loc3_[_loc5_].Type == 1 && _loc3_[_loc5_].Parts.length >= 6)
               {
                  _loc2_.push(_loc3_[_loc5_].ID);
               }
               else if(_loc3_[_loc5_].Type == 2 && _loc3_[_loc5_].Parts.length >= 8)
               {
                  _loc2_.push(_loc3_[_loc5_].ID);
               }
               else if(_loc3_[_loc5_].Type == 3 && _loc3_[_loc5_].Parts.length >= 1)
               {
                  _loc2_.push(_loc3_[_loc5_].ID);
               }
               else if(_loc3_[_loc5_].Type == 4)
               {
                  _loc2_.push(_loc3_[_loc5_].ID);
               }
               else if(_loc3_[_loc5_].Type == 5)
               {
                  _loc2_.push(_loc3_[_loc5_].ID);
               }
               else if(_loc3_[_loc5_].Type == 6)
               {
                  _loc2_.push(_loc3_[_loc5_].ID);
               }
            }
            _loc5_++;
         }
         return _loc2_;
      }
      
      public static function ActivationTotalAttribute() : Array
      {
         var _loc1_:Array = [];
         var _loc2_:Array = FIllustrated.IllustratedInfo;
         var _loc3_:int = int(_loc2_.length);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            if(_loc2_[_loc4_].Type == 1 && _loc2_[_loc4_].Parts.length >= 6)
            {
               _loc1_.push(_loc2_[_loc4_].ID);
            }
            else if(_loc2_[_loc4_].Type == 2 && _loc2_[_loc4_].Parts.length >= 8)
            {
               _loc1_.push(_loc2_[_loc4_].ID);
            }
            else if(_loc2_[_loc4_].Type == 3 && _loc2_[_loc4_].Parts.length >= 1)
            {
               _loc1_.push(_loc2_[_loc4_].ID);
            }
            else if(_loc2_[_loc4_].Type == 4)
            {
               _loc1_.push(_loc2_[_loc4_].ID);
            }
            else if(_loc2_[_loc4_].Type == 5)
            {
               _loc1_.push(_loc2_[_loc4_].ID);
            }
            else if(_loc2_[_loc4_].Type == 6)
            {
               _loc1_.push(_loc2_[_loc4_].ID);
            }
            _loc4_++;
         }
         return _loc1_;
      }
   }
}

