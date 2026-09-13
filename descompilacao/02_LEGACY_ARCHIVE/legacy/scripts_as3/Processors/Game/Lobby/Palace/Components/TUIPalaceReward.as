package Processors.Game.Lobby.Palace.Components
{
   import Foundation.Common.TCoordinate;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.Json.TCrossServerWarReward;
   import Logics.DatebaseVO.VO.TGSPVP_Reward;
   import Processors.Game.TProcessorGame;
   import Resources.Constants.CONST_MODULES;
   import Resources.Strings.STRING_PALACE;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TUIPalaceReward extends TProcessorGame
   {
      
      protected var FTF_Rank:TextField;
      
      protected var FMC_Title:MovieClip;
      
      protected var FMC_Box:MovieClip;
      
      protected var FTitleBmp:Bitmap;
      
      protected var FTitleAnimationID:uint;
      
      protected var FResource:MovieClip;
      
      protected var FUIHintOnOver:Function;
      
      protected var FUIHintOnOut:Function;
      
      protected var FTitleHintOnOver:Function;
      
      protected var FTitleHintOnOut:Function;
      
      protected var FContext:Object;
      
      public function TUIPalaceReward(param1:TUIComponent)
      {
         super(param1);
         this.FTitleBmp = new Bitmap();
         this.FTitleAnimationID = 0;
      }
      
      override protected function LogicsPerform() : void
      {
         if(!this.Parent.Visible)
         {
            return;
         }
         this.UpdateTitleEffect();
         super.LogicsPerform();
      }
      
      protected function UIDispatch() : void
      {
         this.FTF_Rank = this.FResource["TF_Rank"];
         this.FMC_Title = this.FResource["MC_Title"];
         this.FMC_Box = this.FResource["MC_Box"];
         this.FMC_Title.addChild(this.FTitleBmp);
         this.FMC_Box.gotoAndStop(Tag + 1);
      }
      
      protected function UILocations() : void
      {
         this.FMC_Box.addEventListener(MouseEvent.MOUSE_MOVE,this.MCRewardOnOver,false,0,true);
         this.FMC_Box.addEventListener(MouseEvent.MOUSE_OUT,this.MCRewardOnOut,false,0,true);
         this.FMC_Title.addEventListener(MouseEvent.MOUSE_MOVE,this.MCTitleEffectOnOver,false,0,true);
         this.FMC_Title.addEventListener(MouseEvent.MOUSE_OUT,this.MCTitleEffectOnOut,false,0,true);
      }
      
      protected function UpdateUI() : void
      {
         var _loc1_:TGSPVP_Reward = null;
         var _loc2_:String = null;
         var _loc3_:TCrossServerWarReward = null;
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         if(this.FContext != null)
         {
            _loc1_ = this.FContext as TGSPVP_Reward;
            if(Tag == 0)
            {
               _loc2_ = TUtilityString.Format(STRING_PALACE.FORMAT_RankInterval,1);
            }
            else
            {
               _loc2_ = TUtilityString.Format(STRING_PALACE.FORMAT_RankInterval,_loc1_.From) + "~" + TUtilityString.Format(STRING_PALACE.FORMAT_RankInterval,_loc1_.To);
            }
            this.FTF_Rank.text = _loc2_;
            _loc5_ = _loc1_.CrossServerWarRewards.length;
            _loc4_ = 0;
            while(_loc4_ < _loc5_)
            {
               _loc3_ = _loc1_.CrossServerWarRewards[_loc4_];
               if(_loc3_.Type == 12)
               {
                  this.FTitleAnimationID = _loc3_.Code;
               }
               _loc4_++;
            }
         }
      }
      
      protected function UpdateTitleEffect() : void
      {
         var _loc1_:TCoordinate = null;
         if(this.FTitleAnimationID != 0)
         {
            _loc1_ = TGameUtil.ShowAnimationByID(TGameUtil.Type_UserTitle,this.FTitleBmp,CONST_MODULES.MODULE_Palace,this.FTitleAnimationID);
            this.FMC_Title.x = 115 + (110 - this.FMC_Title.width) / 2;
         }
         else
         {
            this.FTitleBmp.bitmapData = null;
         }
      }
      
      protected function MCRewardOnOver(param1:MouseEvent) : void
      {
         if(this.FUIHintOnOver != null)
         {
            this.FUIHintOnOver(this,Tag);
         }
      }
      
      protected function MCRewardOnOut(param1:MouseEvent) : void
      {
         if(this.FUIHintOnOut != null)
         {
            this.FUIHintOnOut(this);
         }
      }
      
      protected function MCTitleEffectOnOver(param1:MouseEvent) : void
      {
         if(this.FTitleHintOnOver != null)
         {
            this.FTitleHintOnOver(this,this.FTitleAnimationID);
         }
      }
      
      protected function MCTitleEffectOnOut(param1:MouseEvent) : void
      {
         if(this.FTitleHintOnOut != null)
         {
            this.FTitleHintOnOut(this);
         }
      }
      
      public function get UIHintOnOver() : Function
      {
         return this.FUIHintOnOver;
      }
      
      public function set UIHintOnOver(param1:Function) : void
      {
         this.FUIHintOnOver = param1;
      }
      
      public function get UIHintOnOut() : Function
      {
         return this.FUIHintOnOut;
      }
      
      public function set UIHintOnOut(param1:Function) : void
      {
         this.FUIHintOnOut = param1;
      }
      
      public function get Resource() : MovieClip
      {
         return this.FResource;
      }
      
      public function set Resource(param1:MovieClip) : void
      {
         this.FResource = param1;
      }
      
      public function get Context() : Object
      {
         return this.FContext;
      }
      
      public function set Context(param1:Object) : void
      {
         this.FContext = param1;
      }
      
      public function get TitleHintOnOver() : Function
      {
         return this.FTitleHintOnOver;
      }
      
      public function set TitleHintOnOver(param1:Function) : void
      {
         this.FTitleHintOnOver = param1;
      }
      
      public function get TitleHintOnOut() : Function
      {
         return this.FTitleHintOnOut;
      }
      
      public function set TitleHintOnOut(param1:Function) : void
      {
         this.FTitleHintOnOut = param1;
      }
      
      public function Init() : void
      {
         this.UIDispatch();
         this.UILocations();
      }
      
      public function Update() : void
      {
         this.UpdateUI();
      }
   }
}

