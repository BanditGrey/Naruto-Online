package Logics.Exercise.FrogWallet
{
   import Logics.Exercise.TBaseActivity;
   
   public class TCornucopia extends TBaseActivity
   {
      
      protected var FCornucopiaList:Vector.<TCornucopiaBox>;
      
      public function TCornucopia()
      {
         super();
         this.FCornucopiaList = new Vector.<TCornucopiaBox>();
      }
      
      public function get CornucopiaList() : Vector.<TCornucopiaBox>
      {
         return this.FCornucopiaList;
      }
      
      public function set CornucopiaList(param1:Vector.<TCornucopiaBox>) : void
      {
         this.FCornucopiaList = param1;
      }
      
      public function ChangeBoxStatus(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         _loc5_ = int(this.FCornucopiaList.length);
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            if(this.FCornucopiaList[_loc4_].Identify == param1)
            {
               this.FCornucopiaList[_loc4_].State = param2;
               FRewardStatus[_loc4_] = param2;
               this.FCornucopiaList[_loc4_].GotTimes = param3;
               break;
            }
            _loc4_++;
         }
      }
   }
}

