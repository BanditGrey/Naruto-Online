package Logics.Exercise.IdolumFight
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.SLogicsCore;
   
   public class TIdolumFight extends TBaseActivity
   {
      
      public var ScoreA:int;
      
      public var Price:int;
      
      public var MaxHp:int;
      
      public var CurHp:int;
      
      public var Round:int;
      
      public var CannonList:Vector.<int>;
      
      public var KillBox:TBaseBox;
      
      public var BigBox:TBaseBox;
      
      public var BoxList:Vector.<TBaseBox>;
      
      public var ShowItems:TInventories;
      
      public function TIdolumFight()
      {
         super();
         this.CannonList = new Vector.<int>();
         this.BoxList = new Vector.<TBaseBox>();
      }
      
      public function ChangeStatus() : void
      {
         if(Boolean(this.BigBox) && Boolean(this.BigBox.Status == TBaseActivity.STATUS_CANNOTGET) && FRankPoint >= this.BigBox.Price)
         {
            this.BigBox.Status = TBaseActivity.STATUS_CANGET;
         }
      }
      
      public function Reset() : void
      {
         this.CurHp = this.MaxHp;
      }
      
      public function CheckStatus() : Boolean
      {
         if(SLogicsCore.ActivityTaskData.NeedShine == TBaseActivity.STATUS_CANGET)
         {
            return true;
         }
         return false;
      }
   }
}

