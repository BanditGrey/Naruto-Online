package Processors.Game.Lobby.Magic.Components
{
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Logics.DatebaseVO.VO.TMewBattle;
   import Logics.SLogicsCore;
   import Processors.Game.TProcessorGame;
   import Resources.Constants.CONST_MAGIC;
   import Resources.Strings.STRING_MAGIC;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TUIMoutain extends TProcessorGame
   {
      
      protected var FMC_Pass:Sprite;
      
      protected var FMC_Locked:Sprite;
      
      protected var FMC_Moutain:Sprite;
      
      protected var FTF_Name:TextField;
      
      protected var FMC_Challenge:MovieClip;
      
      protected var FMC_Icon:MovieClip;
      
      protected var FTF_Enter:TextField;
      
      protected var FResource:MovieClip;
      
      protected var FContext:Object;
      
      protected var FContextCopy:TMewBattle;
      
      protected var FChallengeOnClick:Function;
      
      protected var FThisPanelMove:Function;
      
      protected var FThisPanelOut:Function;
      
      public function TUIMoutain(param1:TUIComponent)
      {
         super(param1);
      }
      
      protected function UIDispatch() : void
      {
         if(this.FResource == null)
         {
            return;
         }
         this.FMC_Pass = this.FResource[CONST_MAGIC.RESOURCE_Link_MC_Pass];
         this.FMC_Pass.visible = false;
         this.FMC_Moutain = this.FResource["MC_Moutain"];
         this.FMC_Challenge = this.FMC_Moutain["BTN_Challenge"];
         TGameUtil.setButtonMode(this.FMC_Challenge,true);
         this.FMC_Icon = this.FMC_Moutain["MC_Icon"];
         this.FTF_Name = this.FMC_Moutain["TF_Name"];
         this.FTF_Enter = this.FMC_Challenge["TF_Enter"];
         this.FMC_Locked = this.FResource["MC_Locked"];
         if(Tag < 7)
         {
            this.FMC_Icon.gotoAndStop(7 - Tag);
         }
         else
         {
            this.FMC_Icon.gotoAndStop(14 - Tag);
         }
      }
      
      protected function UILocations() : void
      {
         this.FMC_Challenge.addEventListener(MouseEvent.CLICK,this.ButtonChallengeOnClick,false,0,true);
         this.FResource.addEventListener(MouseEvent.MOUSE_MOVE,this.ResourceMove);
         this.FResource.addEventListener(MouseEvent.MOUSE_OUT,this.ResourceOut);
      }
      
      protected function UpdateUI() : void
      {
         var _loc1_:TMewBattle = null;
         if(this.FContext is TMewBattle)
         {
            _loc1_ = this.FContext as TMewBattle;
            if(this.FTF_Name != null)
            {
               this.FTF_Name.text = STRING_MAGIC.STRING_Levels[FTag];
            }
            if(SLogicsCore.Character.GetMainLevel() >= this.FContextCopy.NeedLevel)
            {
               this.FMC_Moutain.filters = _loc1_.Location >= Tag ? [] : [TGameUtil.GaryColorFilters];
               this.FResource.mouseChildren = _loc1_.Location >= Tag;
            }
            else
            {
               this.FMC_Moutain.filters = [TGameUtil.GaryColorFilters];
               this.FResource.mouseChildren = false;
            }
            if(_loc1_.Location > Tag && SLogicsCore.Character.GetMainLevel() >= this.FContextCopy.NeedLevel)
            {
               this.FMC_Pass.visible = true;
               this.FMC_Locked.visible = false;
               this.FTF_Enter.text = STRING_MAGIC.STRING_HasPass;
            }
            else if(_loc1_.Location == Tag && SLogicsCore.Character.GetMainLevel() >= this.FContextCopy.NeedLevel)
            {
               if(_loc1_.StageClear != 0)
               {
                  this.FMC_Pass.visible = true;
                  this.FMC_Locked.visible = false;
                  this.FTF_Enter.text = STRING_MAGIC.STRING_HasPass;
               }
               else
               {
                  this.FMC_Pass.visible = false;
                  this.FMC_Locked.visible = false;
                  this.FTF_Enter.text = STRING_MAGIC.STRING_Challenge;
               }
            }
            else
            {
               this.FMC_Pass.visible = false;
               this.FMC_Locked.visible = true;
               this.FTF_Enter.text = STRING_MAGIC.STRING_Locked;
            }
         }
      }
      
      protected function ButtonChallengeOnClick(param1:MouseEvent) : void
      {
         if(this.FChallengeOnClick != null)
         {
            this.FChallengeOnClick(this,FTag);
         }
      }
      
      protected function ResourceMove(param1:MouseEvent) : void
      {
         if(this.FThisPanelMove != null)
         {
            this.FThisPanelMove(this.FContextCopy,Tag);
         }
      }
      
      protected function ResourceOut(param1:MouseEvent) : void
      {
         if(this.FThisPanelOut != null)
         {
            this.FThisPanelOut();
         }
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
      
      public function get ContextCopy() : TMewBattle
      {
         return this.FContextCopy;
      }
      
      public function set ContextCopy(param1:TMewBattle) : void
      {
         this.FContextCopy = param1;
      }
      
      public function get ChallengeOnClick() : Function
      {
         return this.FChallengeOnClick;
      }
      
      public function set ChallengeOnClick(param1:Function) : void
      {
         this.FChallengeOnClick = param1;
      }
      
      public function set ThisPanelMove(param1:Function) : void
      {
         this.FThisPanelMove = param1;
      }
      
      public function set ThisPanelOut(param1:Function) : void
      {
         this.FThisPanelOut = param1;
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

