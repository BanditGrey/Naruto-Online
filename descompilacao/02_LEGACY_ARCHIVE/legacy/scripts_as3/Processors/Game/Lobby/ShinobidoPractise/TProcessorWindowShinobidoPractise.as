package Processors.Game.Lobby.ShinobidoPractise
{
   import Components.Standard.TUITab;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.SLogicsCore;
   import Logics.Unlocks.TUnlock;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Resources.Constants.CONST_SHINOBIDOPRACTISE;
   import Resources.Strings.STRING_SHINOBIDOPRACTISE;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowShinobidoPractise extends TProcessorLobbyWindow
   {
      
      protected static const CAPACITY_TABS:uint = 3;
      
      protected static const CAPACITY_ITEMS:uint = 4;
      
      protected static const RESOURCE_Link_Vector:Vector.<String> = CONST_SHINOBIDOPRACTISE.RESOURCE_Link_Vector;
      
      protected static const POPTIP_Gotos:Vector.<uint> = CONST_SHINOBIDOPRACTISE.POPTIP_Gotos;
      
      protected static const POPTIP_FUNCTION_POSITION:Vector.<Array> = CONST_SHINOBIDOPRACTISE.POPTIP_FUNCTION_POSITION;
      
      protected var FMC_FightingPower:Sprite;
      
      protected var FMC_PageLeft:MovieClip;
      
      protected var FMC_PageRight:MovieClip;
      
      protected var FBtn_Help:SimpleButton;
      
      protected var FBtn_Close:SimpleButton;
      
      protected var FTF_FightingPower:TextField;
      
      protected var FTF_Tittle:TextField;
      
      protected var FBTN_FightingPowerRankings:MovieClip;
      
      protected var FUITab:TUITab;
      
      protected var FMCVec:Vector.<MovieClip>;
      
      protected var FMCModules:Vector.<MovieClip>;
      
      protected var FResource_Links:Vector.<Vector.<String>>;
      
      protected var FTabIndex:int;
      
      protected var FPageIndex:int;
      
      protected var FOnOpenFightingCapacityRank:Function;
      
      protected var FOnHelpTipsOver:Function;
      
      protected var FOnHelpTipsOut:Function;
      
      protected var FOnGoto:Function;
      
      public function TProcessorWindowShinobidoPractise(param1:TUIComponent)
      {
         super(param1);
         this.FUITab = new TUITab(this);
         this.FMCVec = new Vector.<MovieClip>();
         this.FMCModules = new Vector.<MovieClip>(CAPACITY_ITEMS);
         this.FResource_Links = new Vector.<Vector.<String>>();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_SHINOBIDOPRACTISE.RESOURCESID_Swf_ShinobidoPractise);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         this.FMC_FightingPower = TUtilityReflection.CreateDisplayObjectInstance(CONST_SHINOBIDOPRACTISE.RESOURCE_ClassName_MC_ShinobidoPractise) as Sprite;
         addChild(this.FMC_FightingPower);
         this.FBtn_Help = this.FMC_FightingPower[CONST_SHINOBIDOPRACTISE.RESOURCE_Link_BTN_Help];
         this.FBtn_Close = this.FMC_FightingPower[CONST_SHINOBIDOPRACTISE.RESOURCE_Link_BTN_Close];
         this.FTF_FightingPower = this.FMC_FightingPower[CONST_SHINOBIDOPRACTISE.RESOURCE_Link_TF_FightingPower];
         this.FTF_Tittle = this.FMC_FightingPower[CONST_SHINOBIDOPRACTISE.RESOURCE_Link_TF_Tittle];
         this.FBTN_FightingPowerRankings = this.FMC_FightingPower[CONST_SHINOBIDOPRACTISE.RESOURCE_Link_BTN_FightingPowerRankings];
         TGameUtil.setButtonMode(this.FBTN_FightingPowerRankings,true);
         this.FMC_PageLeft = this.FMC_FightingPower[CONST_SHINOBIDOPRACTISE.RESOURCE_Link_MC_PageLeft];
         this.FMC_PageRight = this.FMC_FightingPower[CONST_SHINOBIDOPRACTISE.RESOURCE_Link_MC_PageRight];
         TGameUtil.setButtonMode(this.FMC_PageLeft,true);
         TGameUtil.setButtonMode(this.FMC_PageRight,true);
         this.FResource_Links.push(CONST_SHINOBIDOPRACTISE.RESOURCE_Link_MakeStrong,CONST_SHINOBIDOPRACTISE.RESOURCE_Link_MakeMoney,CONST_SHINOBIDOPRACTISE.RESOURCE_Link_LevelUp);
         _loc2_ = CAPACITY_TABS;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FUITab.SetTabByIndex(this.FMC_FightingPower[CONST_SHINOBIDOPRACTISE.RESOURCE_Link_MC_Tab + _loc1_],_loc1_);
            _loc1_++;
         }
         this.FUITab.OnSwitch = this.TabOnSwitch;
         this.FUITab.Init();
         this.FMCVec.push(this.FMC_FightingPower["MC_Items"]["MC_MakeStrong"]);
         this.FMCVec.push(this.FMC_FightingPower["MC_Items"]["MC_MakeMoney"]);
         this.FMCVec.push(this.FMC_FightingPower["MC_Items"]["MC_LevelUp"]);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBTN_FightingPowerRankings.addEventListener(MouseEvent.CLICK,this.ButtonRankOnClick,false,0,true);
         this.FBtn_Close.addEventListener(MouseEvent.CLICK,this.ButtonCloseOnClick,false,0,true);
         this.FBtn_Help.addEventListener(MouseEvent.MOUSE_MOVE,this.ButtonHelpOnOver,false,0,true);
         this.FBtn_Help.addEventListener(MouseEvent.MOUSE_OUT,this.ButtonHelpOnOut,false,0,true);
         this.FMC_PageLeft.addEventListener(MouseEvent.CLICK,this.ButtonOnPageLeft,false,0,true);
         this.FMC_PageRight.addEventListener(MouseEvent.CLICK,this.ButtonOnPageRight,false,0,true);
         super.ResourcesPerform_UILocations();
      }
      
      protected function UpdateMCUI() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:int = 0;
         _loc2_ = this.FMCVec.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(_loc1_ == this.FTabIndex)
            {
               this.FMCVec[_loc1_].visible = true;
            }
            else
            {
               this.FMCVec[_loc1_].visible = false;
            }
            _loc1_++;
         }
         _loc2_ = this.FMCModules.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FMCModules[_loc1_] = this.FMCVec[this.FTabIndex][CONST_SHINOBIDOPRACTISE.RESOURCE_Link_MC_Item + _loc1_];
            if(this.FPageIndex * CAPACITY_ITEMS + _loc1_ >= this.FResource_Links[this.FTabIndex].length)
            {
               this.FMCModules[_loc1_].visible = false;
            }
            else
            {
               this.FMCModules[_loc1_].gotoAndStop(this.FResource_Links[this.FTabIndex][this.FPageIndex * CAPACITY_ITEMS + _loc1_]);
               _loc3_ = this.FMCModules[_loc1_][this.FMCModules[_loc1_].currentFrameLabel];
               this.FMCModules[_loc1_].visible = true;
               _loc4_ = 0;
               while(_loc4_ < RESOURCE_Link_Vector.length)
               {
                  if(RESOURCE_Link_Vector[_loc4_] == _loc3_.name)
                  {
                     if(this.VerificationLocaltionOperatingByPosition(POPTIP_FUNCTION_POSITION[_loc4_][0],POPTIP_FUNCTION_POSITION[_loc4_][1]))
                     {
                        _loc3_.addEventListener(MouseEvent.CLICK,this.ButtonOnGoto,false,0,true);
                        TGameUtil.setButtonMode(_loc3_,true);
                        _loc3_.mouseEnabled = true;
                        _loc3_.filters = [];
                     }
                     else
                     {
                        TGameUtil.setButtonMode(_loc3_,false);
                        _loc3_.mouseEnabled = false;
                        _loc3_.filters = [TGameUtil.rBlackFilters];
                     }
                  }
                  _loc4_++;
               }
            }
            _loc1_++;
         }
      }
      
      protected function VerificationLocaltionOperatingByPosition(param1:uint, param2:uint) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TUnlock = null;
         var _loc6_:Boolean = false;
         _loc6_ = false;
         _loc4_ = int(SLogicsCore.Unlocks.Count);
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = SLogicsCore.Unlocks.GetUnlockByIndex(_loc3_);
            if(param1 == _loc5_.Position && param2 == _loc5_.Localtion)
            {
               if(_loc5_.State == TUnlock.UNLOCKSTATE_Unlocked)
               {
                  _loc6_ = true;
                  break;
               }
            }
            _loc3_++;
         }
         return _loc6_;
      }
      
      protected function UpdatePageInfo() : void
      {
         var _loc1_:uint = 0;
         _loc1_ = Math.floor(this.FResource_Links[this.FTabIndex].length / CAPACITY_ITEMS);
         if(this.FResource_Links[this.FTabIndex].length < CAPACITY_ITEMS)
         {
            this.SetBTNPageState(false,false);
         }
         else if(this.FPageIndex > 0 && this.FPageIndex < _loc1_)
         {
            this.SetBTNPageState(true,true);
         }
         else if(this.FPageIndex == _loc1_)
         {
            this.SetBTNPageState(true,false);
         }
         else if(this.FPageIndex == 0)
         {
            this.SetBTNPageState(false,true);
         }
      }
      
      protected function SetBTNPageState(param1:Boolean, param2:Boolean) : void
      {
         TGameUtil.setButtonMode(this.FMC_PageLeft,param1);
         this.FMC_PageLeft.mouseEnabled = param1;
         TGameUtil.setButtonMode(this.FMC_PageRight,param2);
         this.FMC_PageRight.mouseEnabled = param2;
      }
      
      protected function UpdateTextFieldInfo() : void
      {
         this.FTF_Tittle.text = STRING_SHINOBIDOPRACTISE.STRING_TITLEVEC[this.FTabIndex];
         this.FTF_FightingPower.text = SLogicsCore.Character.GetFightingPowerPVE().ToString();
      }
      
      protected function ButtonCloseOnClick(param1:MouseEvent) : void
      {
         ProcessorWindowClose();
      }
      
      protected function ButtonOnGoto(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:String = null;
         _loc4_ = param1.currentTarget.name;
         _loc3_ = RESOURCE_Link_Vector.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            if(_loc4_ == RESOURCE_Link_Vector[_loc2_])
            {
               if(this.FOnGoto != null)
               {
                  this.FOnGoto(this,POPTIP_Gotos[_loc2_]);
               }
            }
            _loc2_++;
         }
      }
      
      protected function ButtonHelpOnOver(param1:MouseEvent) : void
      {
      }
      
      protected function ButtonHelpOnOut(param1:MouseEvent) : void
      {
      }
      
      protected function ButtonRankOnClick(param1:MouseEvent) : void
      {
         if(this.FOnOpenFightingCapacityRank != null)
         {
            this.FOnOpenFightingCapacityRank(this);
         }
      }
      
      protected function TabOnSwitch(param1:Object) : void
      {
         this.FTabIndex = param1 as int;
         this.FPageIndex = 0;
         this.UpdateTextFieldInfo();
         this.UpdatePageInfo();
         this.UpdateMCUI();
      }
      
      protected function ButtonOnPageLeft(param1:MouseEvent) : void
      {
         --this.FPageIndex;
         if(this.FPageIndex < 0)
         {
            this.FPageIndex = 0;
         }
         this.UpdatePageInfo();
         this.UpdateMCUI();
      }
      
      protected function ButtonOnPageRight(param1:MouseEvent) : void
      {
         ++this.FPageIndex;
         this.UpdatePageInfo();
         this.UpdateMCUI();
      }
      
      public function get OnOpenFightingCapacityRank() : Function
      {
         return this.FOnOpenFightingCapacityRank;
      }
      
      public function set OnOpenFightingCapacityRank(param1:Function) : void
      {
         this.FOnOpenFightingCapacityRank = param1;
      }
      
      public function get OnHelpTipsOver() : Function
      {
         return this.FOnHelpTipsOver;
      }
      
      public function set OnHelpTipsOver(param1:Function) : void
      {
         this.FOnHelpTipsOver = param1;
      }
      
      public function get OnHelpTipsOut() : Function
      {
         return this.FOnHelpTipsOut;
      }
      
      public function set OnHelpTipsOut(param1:Function) : void
      {
         this.FOnHelpTipsOut = param1;
      }
      
      public function get OnGoto() : Function
      {
         return this.FOnGoto;
      }
      
      public function set OnGoto(param1:Function) : void
      {
         this.FOnGoto = param1;
      }
      
      public function Init() : void
      {
         this.FUITab.SwithTagManual(this.FTabIndex);
         this.UpdatePageInfo();
         this.UpdateTextFieldInfo();
         this.UpdateMCUI();
      }
   }
}

