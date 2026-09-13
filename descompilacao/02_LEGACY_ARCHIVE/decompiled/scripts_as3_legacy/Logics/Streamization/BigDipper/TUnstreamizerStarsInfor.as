package Logics.Streamization.BigDipper
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Logics.BigDipper.TStarInfor;
   import Logics.BigDipper.TStarsInfor;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TServenStar;
   import Logics.DatebaseVO.VO.TServenStarExp;
   import Logics.DatebaseVO.VO.TStarPointDesc;
   import Logics.GeneralStar.TEsotericPoint;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerStarsInfor extends TUnstreamizer
   {
      
      protected var FBinsStarPointDes:TBins;
      
      protected var FBinsSevenStar:TBins;
      
      protected var FBinsBigDipperExp:TBins;
      
      public function TUnstreamizerStarsInfor(param1:TBins, param2:TBins, param3:TBins)
      {
         super();
         this.FBinsStarPointDes = param1;
         this.FBinsSevenStar = param2;
         this.FBinsBigDipperExp = param3;
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:TStarsInfor = null;
         var _loc6_:TStarInfor = null;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:int = 0;
         var _loc10_:TConfigValue = null;
         _loc10_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,60103002) as TConfigValue;
         _loc5_ = TStarsInfor(param2);
         _loc5_.FreeTime = int(_loc10_.Value) - param1.readByte();
         _loc9_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc9_)
         {
            _loc7_ = param1.readUnsignedInt();
            _loc6_ = _loc5_.GetStarByStarNameID(_loc7_);
            _loc6_.CurrentExp = param1.readUnsignedInt();
            _loc6_.StarLevel = param1.readUnsignedInt();
            this.UnstreamizationPerform_BigDipperByDatabase(_loc6_);
            _loc4_++;
         }
         _loc5_.FplayTimes = int(param1.readUnsignedInt());
      }
      
      protected function ChangeFormatString(param1:int, param2:String) : String
      {
         var _loc3_:Number = NaN;
         if(param1 == 29)
         {
            _loc3_ = parseFloat(param2) * 100;
            return _loc3_.toFixed(1) + "%";
         }
         return parseInt(param2).toString();
      }
      
      public function UnstreamizationPerform_BigDipperByDatabase(param1:TStarInfor) : void
      {
         var _loc2_:TServenStarExp = null;
         var _loc3_:TEsotericPoint = null;
         var _loc4_:TConfigValue = null;
         param1.StarID = param1.StarLevel + param1.StarNameID + 1;
         _loc2_ = this.FBinsBigDipperExp.GetDatebaseByIdentifier(param1.StarID) as TServenStarExp;
         param1.UpgradeNeedExp = _loc2_.NeedExp;
         param1.AttributeValue = this.ChangeFormatString(_loc2_.Type,_loc2_.Value);
         _loc2_ = this.FBinsBigDipperExp.GetDatebaseByIdentifier(param1.StarID + 1) as TServenStarExp;
         if(_loc2_ == null)
         {
            param1.StarNextAddAttrValue = null;
         }
         else
         {
            param1.StarNextAddAttrValue = this.ChangeFormatString(_loc2_.Type,_loc2_.Value);
         }
      }
      
      public function UnstreamizationPerform_BigDipperByDatabaseCommon(param1:TStarInfor) : void
      {
         var _loc2_:TStarPointDesc = null;
         var _loc3_:TServenStar = null;
         var _loc4_:TServenStarExp = null;
         param1.StarID = param1.StarLevel + param1.StarNameID + 1;
         _loc4_ = this.FBinsBigDipperExp.GetDatebaseByIdentifier(param1.StarID) as TServenStarExp;
         param1.AttributeType = _loc4_.Type;
         _loc4_ = this.FBinsBigDipperExp.GetDatebaseByIdentifier(param1.StarID + 1) as TServenStarExp;
         _loc2_ = this.FBinsStarPointDes.GetDatebaseByIdentifier(param1.AttributeType + 17500000) as TStarPointDesc;
         param1.AttributeName = _loc2_.Desc;
         _loc3_ = this.FBinsSevenStar.GetDatebaseByIdentifier(param1.StarNameID) as TServenStar;
         param1.StarName = _loc3_.Name;
      }
   }
}

