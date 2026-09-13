package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   
   use namespace ResourcesSpace;
   
   public class TFettersTeam extends TDatebaseVO
   {
      
      protected var FTeamId:String;
      
      protected var FTeamName:String;
      
      protected var FFormationOne:uint;
      
      protected var FTeamOne:String;
      
      protected var FDescriptionOne:String;
      
      protected var FFormationDouble:uint;
      
      protected var FTeamDouble:String;
      
      protected var FDescriptionDouble:String;
      
      protected var FFormationTriple:uint;
      
      protected var FTeamTriple:String;
      
      protected var FDescriptionTriple:String;
      
      protected var FFormationUltra:uint;
      
      protected var FTeamUltra:String;
      
      protected var FDescriptionUltra:String;
      
      protected var FFormationPenta:uint;
      
      protected var FTeamPenta:String;
      
      protected var FDescriptionPenta:String;
      
      public function TFettersTeam()
      {
         super();
      }
      
      override ResourcesSpace function ReadDataByXml(param1:XML) : void
      {
         var _loc2_:XML = null;
         var _loc3_:String = null;
         var _loc4_:* = undefined;
         var _loc5_:uint = 0;
         var _loc6_:int = 0;
         _loc5_ = uint(param1.elements().length());
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc2_ = param1.elements()[_loc6_];
            _loc3_ = String(_loc2_.name());
            _loc4_ = _loc2_;
            if(_loc3_ == "id")
            {
               Coerce(uint(_loc4_));
            }
            else
            {
               _loc3_ = "F" + _loc3_;
               if(hasOwnProperty(_loc3_))
               {
                  this[_loc3_] = _loc4_;
               }
               else
               {
                  if(Count_AttributeName.indexOf(_loc3_.slice(1,2)) < 0)
                  {
                     _loc3_ = "F" + _loc3_.slice(1,2).toLocaleUpperCase() + _loc3_.slice(2);
                  }
                  if(hasOwnProperty(_loc3_.slice(1)))
                  {
                     if(this[_loc3_] is Boolean)
                     {
                        this[_loc3_] = Boolean(int(_loc4_));
                     }
                     else
                     {
                        this[_loc3_] = _loc4_;
                     }
                  }
               }
            }
            _loc6_++;
         }
      }
      
      override ResourcesSpace function WriteDataToStream(param1:ByteArray) : void
      {
         param1.writeUnsignedInt(FIdentifier);
         TUtilityString.FlushUTF(param1,this.FTeamId);
         TUtilityString.FlushUTF(param1,this.FTeamName);
         param1.writeUnsignedInt(this.FFormationOne);
         TUtilityString.FlushUTF(param1,this.FTeamOne);
         TUtilityString.FlushUTF(param1,this.FDescriptionOne);
         param1.writeUnsignedInt(this.FFormationDouble);
         TUtilityString.FlushUTF(param1,this.FTeamDouble);
         TUtilityString.FlushUTF(param1,this.FDescriptionDouble);
         param1.writeUnsignedInt(this.FFormationTriple);
         TUtilityString.FlushUTF(param1,this.FTeamTriple);
         TUtilityString.FlushUTF(param1,this.FDescriptionTriple);
         param1.writeUnsignedInt(this.FFormationUltra);
         TUtilityString.FlushUTF(param1,this.FTeamUltra);
         TUtilityString.FlushUTF(param1,this.FDescriptionUltra);
         param1.writeUnsignedInt(this.FFormationPenta);
         TUtilityString.FlushUTF(param1,this.FTeamPenta);
         TUtilityString.FlushUTF(param1,this.FDescriptionPenta);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FTeamId = TUtilityString.FetchUTF(param1);
         this.FTeamName = TUtilityString.FetchUTF(param1);
         this.FFormationOne = param1.readUnsignedInt();
         this.FTeamOne = TUtilityString.FetchUTF(param1);
         this.FDescriptionOne = TUtilityString.FetchUTF(param1);
         this.FFormationDouble = param1.readUnsignedInt();
         this.FTeamDouble = TUtilityString.FetchUTF(param1);
         this.FDescriptionDouble = TUtilityString.FetchUTF(param1);
         this.FFormationTriple = param1.readUnsignedInt();
         this.FTeamTriple = TUtilityString.FetchUTF(param1);
         this.FDescriptionTriple = TUtilityString.FetchUTF(param1);
         this.FFormationUltra = param1.readUnsignedInt();
         this.FTeamUltra = TUtilityString.FetchUTF(param1);
         this.FDescriptionUltra = TUtilityString.FetchUTF(param1);
         this.FFormationPenta = param1.readUnsignedInt();
         this.FTeamPenta = TUtilityString.FetchUTF(param1);
         this.FDescriptionPenta = TUtilityString.FetchUTF(param1);
      }
      
      public function get TeamId() : String
      {
         return this.FTeamId;
      }
      
      public function get TeamName() : String
      {
         return this.FTeamName;
      }
      
      public function get FormationOne() : uint
      {
         return this.FFormationOne;
      }
      
      public function get TeamOne() : String
      {
         return this.FTeamOne;
      }
      
      public function get DescriptionOne() : String
      {
         return this.FDescriptionOne;
      }
      
      public function get FormationDouble() : uint
      {
         return this.FFormationDouble;
      }
      
      public function get TeamDouble() : String
      {
         return this.FTeamDouble;
      }
      
      public function get DescriptionDouble() : String
      {
         return this.FDescriptionDouble;
      }
      
      public function get FormationTriple() : uint
      {
         return this.FFormationTriple;
      }
      
      public function get TeamTriple() : String
      {
         return this.FTeamTriple;
      }
      
      public function get DescriptionTriple() : String
      {
         return this.FDescriptionTriple;
      }
      
      public function get FormationUltra() : uint
      {
         return this.FFormationUltra;
      }
      
      public function get TeamUltra() : String
      {
         return this.FTeamUltra;
      }
      
      public function get DescriptionUltra() : String
      {
         return this.FDescriptionUltra;
      }
      
      public function get FormationPenta() : uint
      {
         return this.FFormationPenta;
      }
      
      public function get TeamPenta() : String
      {
         return this.FTeamPenta;
      }
      
      public function get DescriptionPenta() : String
      {
         return this.FDescriptionPenta;
      }
   }
}

