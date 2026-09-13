package Logics.TransmigrationAccessory
{
   public class TTransmigrationAccessoryData
   {
      
      protected var FAccessoryCampaignList:Vector.<TAccessoryCampaign>;
      
      public function TTransmigrationAccessoryData()
      {
         super();
         this.FAccessoryCampaignList = new Vector.<TAccessoryCampaign>();
      }
      
      public function get AccessoryCampaignList() : Vector.<TAccessoryCampaign>
      {
         return this.FAccessoryCampaignList;
      }
      
      public function AddAccessoryCampaign(param1:TAccessoryCampaign) : void
      {
         this.FAccessoryCampaignList.push(param1);
      }
      
      public function GetAccessoryCampaignByCampaignId(param1:uint) : TAccessoryCampaign
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TAccessoryCampaign = null;
         _loc2_ = 0;
         while(_loc2_ < this.FAccessoryCampaignList.length)
         {
            _loc4_ = this.FAccessoryCampaignList[_loc2_];
            if(_loc4_.CampaignId == param1)
            {
               return _loc4_;
            }
            _loc2_++;
         }
         return null;
      }
      
      public function IsAttacked() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TAccessoryCampaign = null;
         var _loc4_:Boolean = false;
         _loc4_ = false;
         _loc1_ = 0;
         while(_loc1_ < this.FAccessoryCampaignList.length)
         {
            _loc3_ = this.FAccessoryCampaignList[_loc1_];
            if(_loc3_.CurStageId != 0)
            {
               _loc4_ = true;
               break;
            }
            _loc1_++;
         }
         return _loc4_;
      }
   }
}

