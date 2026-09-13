package Logics.Streamization.Wing
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Logics.TransmigrationTrial.TTrialCampaign;
   import Logics.Wing.TWing;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerWing extends TUnstreamizer
   {
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      public function TUnstreamizerWing()
      {
         super();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:TInventory = null;
         var _loc11_:TInventories = null;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         var _loc14_:uint = 0;
         var _loc15_:Vector.<uint> = null;
         var _loc16_:Vector.<uint> = null;
         var _loc17_:TBins = null;
         var _loc18_:TBaseBox = null;
         var _loc19_:Vector.<int> = null;
         var _loc20_:Vector.<int> = null;
         var _loc21_:TWing = null;
         var _loc22_:uint = 0;
         var _loc23_:TTrialCampaign = null;
         _loc15_ = new Vector.<uint>();
         _loc16_ = new Vector.<uint>();
         _loc19_ = new Vector.<int>();
         _loc20_ = new Vector.<int>();
         _loc21_ = param2 as TWing;
         _loc17_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         _loc21_.WingID = param1.readUnsignedInt();
         _loc21_.CurExp = param1.readUnsignedInt();
         _loc21_.TransformID = param1.readUnsignedInt();
         _loc21_.TransformTime = param1.readUnsignedInt();
         _loc21_.StrengthenConfig.length = 0;
         _loc7_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            _loc18_ = new TBaseBox();
            _loc18_.Count = param1.readUnsignedInt();
            _loc18_.Level = param1.readUnsignedInt();
            _loc18_.Price = param1.readUnsignedInt();
            _loc18_.Min = param1.readUnsignedInt();
            _loc18_.Max = param1.readUnsignedInt();
            _loc21_.StrengthenConfig[_loc4_] = _loc18_;
            _loc4_++;
         }
         _loc21_.ColorfulFeather = param1.readUnsignedInt();
         _loc21_.Stone = param1.readUnsignedInt();
         _loc7_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            _loc22_ = param1.readUnsignedInt();
            _loc23_ = _loc21_.GetTrialCampaignByCampaignId(_loc22_);
            if(_loc23_ == null)
            {
               _loc23_ = new TTrialCampaign();
               _loc21_.AddTrialCampaign(_loc23_);
            }
            _loc23_.CampaignId = _loc22_;
            _loc23_.CurStageId = param1.readUnsignedInt();
            _loc23_.HistoryStageId = param1.readUnsignedInt();
            _loc23_.TodayResetTimes = param1.readUnsignedInt();
            _loc4_++;
         }
         _loc21_.TransformWings.length = 0;
         _loc7_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            _loc18_ = new TBaseBox();
            _loc18_.Identify = param1.readUnsignedInt();
            _loc18_.Time = param1.readUnsignedInt();
            _loc18_.TotalTms = param1.readUnsignedInt();
            _loc21_.TransformWings[_loc4_] = _loc18_;
            _loc4_++;
         }
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

