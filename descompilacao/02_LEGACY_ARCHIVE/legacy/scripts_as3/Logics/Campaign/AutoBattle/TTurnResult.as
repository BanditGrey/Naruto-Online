package Logics.Campaign.AutoBattle
{
   import Logics.Items.TItem;
   import Logics.Items.TItems;
   
   public class TTurnResult
   {
      
      protected var FWaveReward:Vector.<TItems>;
      
      protected var FEndReward:TItems;
      
      protected var FAddReward:TItem;
      
      public function TTurnResult()
      {
         super();
         this.WaveReward = new Vector.<TItems>();
         this.FEndReward = new TItems();
      }
      
      public function get WaveReward() : Vector.<TItems>
      {
         return this.FWaveReward;
      }
      
      public function set WaveReward(param1:Vector.<TItems>) : void
      {
         this.FWaveReward = param1;
      }
      
      public function get EndReward() : TItems
      {
         return this.FEndReward;
      }
      
      public function set EndReward(param1:TItems) : void
      {
         this.FEndReward = param1;
      }
      
      public function get AddReward() : TItem
      {
         return this.FAddReward;
      }
      
      public function set AddReward(param1:TItem) : void
      {
         this.FAddReward = param1;
      }
   }
}

