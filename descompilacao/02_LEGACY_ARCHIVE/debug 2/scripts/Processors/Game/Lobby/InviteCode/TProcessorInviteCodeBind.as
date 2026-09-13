package Processors.Game.Lobby.InviteCode
{
   import Components.ScrollBar.TScrollBar;
   import Processors.Game.Lobby.InviteCode.Components.TInviteCodeBind;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorInviteCodeBind
   {
      
      protected var FMCScene:MovieClip;
      
      protected var FBtn_Bind:SimpleButton;
      
      protected var FTF_Input:TextField;
      
      protected var FScrollBar:TScrollBar;
      
      protected var FInviteCodeBindList:Array;
      
      protected var FOnOver:Function;
      
      protected var FOnOut:Function;
      
      public var RequestBindFun:Function;
      
      public var TotalGold:int;
      
      public function TProcessorInviteCodeBind()
      {
         super();
      }
      
      protected function ResourcesPerformUIDispatch(param1:MovieClip) : void
      {
         this.FMCScene = param1;
         this.FBtn_Bind = param1["FBtn_Bind"];
         this.FBtn_Bind.addEventListener(MouseEvent.CLICK,this.OnClickBtnbind);
         this.FTF_Input = param1["TF_Input"];
         this.FScrollBar = new TScrollBar(this.FMCScene["mc_list"],364,false,10,0,false,3,30);
         this.FScrollBar.SetScrollVisble(true);
      }
      
      public function UpdateInviteCodeList(param1:Vector.<Object>) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TInviteCodeBind = null;
         var _loc5_:Object = null;
         _loc2_ = int(param1.length);
         this.FScrollBar.Clear();
         this.FInviteCodeBindList = [];
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = new TInviteCodeBind(this.FMCScene);
            _loc5_ = param1[_loc3_];
            _loc4_.SetCodeInfo(_loc5_,this.TotalGold);
            _loc4_.OnOver = this.SlotsOnOver;
            _loc4_.OnOut = this.SlotsOnOut;
            this.FScrollBar.AddItem(_loc4_);
            this.FInviteCodeBindList.push(_loc4_);
            _loc3_++;
         }
      }
      
      public function Perform_UIDispatch(param1:MovieClip) : void
      {
         this.ResourcesPerformUIDispatch(param1);
      }
      
      public function UpdateSlot() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TInviteCodeBind = null;
         if(this.FInviteCodeBindList)
         {
            _loc1_ = 0;
            while(_loc1_ < this.FInviteCodeBindList.length)
            {
               _loc2_ = this.FInviteCodeBindList[_loc1_];
               _loc2_.UpdateSlot();
               _loc1_++;
            }
         }
      }
      
      public function set Visible(param1:Boolean) : void
      {
         this.FMCScene.visible = param1;
      }
      
      protected function OnClickBtnbind(param1:MouseEvent) : void
      {
         if(this.RequestBindFun != null)
         {
            this.RequestBindFun(this.FTF_Input.text);
         }
      }
      
      protected function SlotsOnOver(param1:Object, param2:Object) : void
      {
         if(this.FOnOver != null)
         {
            this.FOnOver(param1,param2);
         }
      }
      
      protected function SlotsOnOut(param1:Object, param2:Object) : void
      {
         if(this.FOnOut != null)
         {
            this.FOnOut(param1,param2);
         }
      }
      
      public function set OnOver(param1:Function) : void
      {
         this.FOnOver = param1;
      }
      
      public function set OnOut(param1:Function) : void
      {
         this.FOnOut = param1;
      }
   }
}

