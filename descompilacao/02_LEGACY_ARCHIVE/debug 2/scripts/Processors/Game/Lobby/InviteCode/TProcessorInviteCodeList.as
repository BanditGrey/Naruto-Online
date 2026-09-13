package Processors.Game.Lobby.InviteCode
{
   import Components.ScrollBar.TScrollBar;
   import Processors.Game.Lobby.InviteCode.Components.TInviteCodeList;
   import flash.display.MovieClip;
   
   public class TProcessorInviteCodeList
   {
      
      protected var FMCScene:MovieClip;
      
      protected var FScrollBar:TScrollBar;
      
      public function TProcessorInviteCodeList()
      {
         super();
      }
      
      protected function ResourcesPerformUIDispatch(param1:MovieClip) : void
      {
         this.FMCScene = param1;
         this.FScrollBar = new TScrollBar(this.FMCScene["mc_list"],420,false,0);
         this.FScrollBar.SetScrollVisble(true);
      }
      
      public function UpdateInviteCodeList(param1:Array) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TInviteCodeList = null;
         var _loc5_:Object = null;
         _loc2_ = int(param1.length);
         this.FScrollBar.Clear();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = new TInviteCodeList(this.FMCScene);
            _loc5_ = param1[_loc3_];
            _loc4_.SetCodeInfo(_loc5_);
            this.FScrollBar.AddItem(_loc4_);
            _loc3_++;
         }
      }
      
      public function Perform_UIDispatch(param1:MovieClip) : void
      {
         this.ResourcesPerformUIDispatch(param1);
      }
      
      public function set Visible(param1:Boolean) : void
      {
         this.FMCScene.visible = param1;
      }
   }
}

