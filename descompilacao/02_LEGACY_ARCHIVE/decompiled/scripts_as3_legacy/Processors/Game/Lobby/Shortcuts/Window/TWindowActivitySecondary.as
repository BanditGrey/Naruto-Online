package Processors.Game.Lobby.Shortcuts.Window
{
   import Components.Shortcuts.TUIShortcut;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TAnimationSequence;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Processors.Game.Lobby.Common.Shortcuts.TLobbyShortcutActivityModes;
   import Processors.Game.Lobby.Common.Shortcuts.TLobbyShortcutMode;
   import Resources.Constants.CONST_LOBBY;
   import Resources.Constants.CONST_SHORTCUTS;
   import flash.display.Bitmap;
   import flash.display.SimpleButton;
   import flash.utils.ByteArray;
   import ghostcat.operation.RepeatOper;
   import ghostcat.operation.TweenOper;
   import ghostcat.util.easing.TweenEvent;
   
   public class TWindowActivitySecondary extends TUIComponent
   {
      
      public static const TYPE_Activity_NarutoRoad:uint = 0;
      
      public static const TYPE_Activity_Slave:uint = 1;
      
      public static const TYPE_Activity_SevenKing:uint = 2;
      
      public static const TYPE_Activity_CrossServerWar:uint = 3;
      
      public static const TYPE_Activity_SubmitBug:uint = 4;
      
      public static const TYPE_Activity_Magic:uint = 5;
      
      public static const TYPE_Activity_Moutain:uint = 6;
      
      public static const TYPE_Activity_Tower:uint = 7;
      
      public static const TYPE_Activity_DailyWelfare:uint = 8;
      
      public static const TYPE_Activity_Palace:uint = 9;
      
      public static const TYPE_Activity_NijiaStar:uint = 10;
      
      public static const TYPE_Activity_Ramen:uint = 11;
      
      public static const TYPE_Activity_TopOrganization:uint = 12;
      
      public static const TYPE_Activity_GroupBattle:uint = 13;
      
      public static const TYPE_Activity_Laboratory:uint = 14;
      
      public static const TYPE_Activity_SixFairy:uint = 15;
      
      public static const TYPE_Activity_RebirthRealm:uint = 16;
      
      public static const TYPE_Activity_NijiaMystic:uint = 17;
      
      public static const TYPE_Activity_TopTeam:uint = 18;
      
      public static const TYPE_Activity_NarutoHelper:uint = 19;
      
      public static const TYPE_Activity_Choose:uint = 20;
      
      public static const TYPE_Activity_NinjaRelation:uint = 21;
      
      public static const TYPE_Activity_NinjaHostel:uint = 22;
      
      public static const TYPE_Activity_BloodFete:uint = 23;
      
      public static const TYPE_Activity_EpicEquip:uint = 24;
      
      public static const TYPE_Activity_Taboo:uint = 25;
      
      public static const TYPE_Activity_Awaken:uint = 26;
      
      public static const TYPE_Activity_TransmigrationAccessory:uint = 27;
      
      public static const TYPE_Activity_EightDoor:uint = 28;
      
      public static const TYPE_Activity_TheWorldTree:uint = 29;
      
      public static const TYPE_Activity_Undertown:uint = 30;
      
      public static const TYPE_Activity_LostShenQi:uint = 31;
      
      public static const TYPE_Activity_Wing:uint = 32;
      
      public static const TYPE_Activity_Challenge:uint = 33;
      
      public static const TYPE_Activity_Illustrated:uint = 34;
      
      public static const TYPE_Activity_Aline:uint = 36;
      
      public static const TYPE_Activity_KingWar:uint = 37;
      
      public static const TYPE_Activity_Medal:uint = 38;
      
      public static const TYPE_Activity_InviteCode:uint = 39;
      
      public static const TYPE_Activity_Wuxing:uint = 40;
      
      public static const TYPE_Activity_GlobalBattle:uint = 41;
      
      public static const TYPE_Activity_Emblem:uint = 42;
      
      public static const TYPE_Activity_WorldMatch:uint = 43;
      
      public static const TYPE_Activity_SummonBattle:uint = 44;
      
      public static const TYPE_Activity_NinjaTalent:uint = 45;
      
      public static const TYPE_Activity_ChallengCamp:uint = 46;
      
      public static const TYPE_Activity_GlobalBoss:uint = 47;
      
      public static const TYPE_Activity_Recruit:uint = 48;
      
      public static const TYPE_Activity_CrossSlave:uint = 49;
      
      public static const ACTIVITYS_TYPE_Special:Vector.<uint> = CONST_SHORTCUTS.ACTIVITYS_TYPE_Special;
      
      public static const RESOURCE_ClassName_Activity_Btns:Vector.<String> = CONST_SHORTCUTS.RESOURCE_ClassName_Activity_Btns;
      
      public static const RESOURCE_ClassName_ActivitySecondary_Bmps:Vector.<String> = CONST_SHORTCUTS.RESOURCE_ClassName_ActivitySecondary_Bmps;
      
      protected static const COORDINATE_ActivityBtn:Vector.<int> = Vector.<int>([1,7]);
      
      protected static const COLOR_ContextDefault:uint = 4294967295;
      
      protected var FRepeatOper:RepeatOper;
      
      protected var FTweenOperIn:TweenOper;
      
      protected var FTweenOperOut:TweenOper;
      
      protected var FBmp_Pointer:Bitmap;
      
      protected var FUIShortcut:TUIShortcut;
      
      protected var FIsInitialization:Boolean;
      
      protected var FStreamParameter:ByteArray;
      
      protected var FIsEffects:Vector.<Boolean>;
      
      protected var FTargetIndex:uint;
      
      protected var FOnActivitySecondary:Function;
      
      public function TWindowActivitySecondary(param1:TUIComponent)
      {
         super(param1);
         this.FUIShortcut = new TUIShortcut(this);
         this.FUIShortcut.Capacity = ACTIVITYS_TYPE_Special.length;
         this.ConstructTweens();
         this.FStreamParameter = new ByteArray();
      }
      
      protected function ConstructTweens() : void
      {
         this.FRepeatOper = new RepeatOper();
         this.FTweenOperIn = new TweenOper();
         this.FTweenOperOut = new TweenOper();
         this.FTweenOperIn.duration = 10;
         this.FTweenOperIn.target = this;
         this.FTweenOperOut.duration = 150;
         this.FTweenOperOut.target = this;
         this.FRepeatOper.loop = 1;
         this.FRepeatOper.children = [this.FTweenOperIn,this.FTweenOperOut];
      }
      
      protected function Resources_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:SimpleButton = null;
         var _loc5_:TAnimationSequence = null;
         var _loc6_:Bitmap = null;
         _loc2_ = int(RESOURCE_ClassName_ActivitySecondary_Bmps.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc6_ = TUtilityReflection.CreateBitmapByDisplayObject(CONST_SHORTCUTS.RESOURCE_ClassName_ActivitySecondary_Bmps[_loc1_]);
            this.FUIShortcut.NineGridBitmaps[_loc1_] = _loc6_;
            _loc1_++;
         }
         _loc5_ = SResourcesCore.TexturesLobby.GetAnimationSequenceByIdentifiers(CONST_LOBBY.RESOURCESID_Textures_ShortcutEffect,0);
         this.FUIShortcut.Effects = _loc5_;
         this.FBmp_Pointer = TUtilityReflection.CreateBitmapByDisplayObject(CONST_SHORTCUTS.RESOURCE_ClassName_ActivitySecondary_Bmp_Pointer);
         _loc2_ = int(ACTIVITYS_TYPE_Special.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = RESOURCE_ClassName_Activity_Btns[ACTIVITYS_TYPE_Special[_loc1_]];
            _loc4_ = TUtilityReflection.CreateSimpleButtonByDisplayObject(_loc3_) as SimpleButton;
            if(_loc4_ == null)
            {
               _loc4_ = TUtilityReflection.CreateSimpleButtonByDisplayObject("Shortcuts_Activity_SubmitBug") as SimpleButton;
            }
            _loc4_.visible = false;
            this.FUIShortcut.SetButtonByIndex(_loc4_,_loc1_);
            _loc1_++;
         }
      }
      
      protected function Resources_UILocations() : void
      {
         this.FUIShortcut.CoordinateBtn = COORDINATE_ActivityBtn;
         this.FUIShortcut.Perform_UIDispatch_SecondaryList();
         addChild(this.FBmp_Pointer);
         this.InitializationActivitys();
      }
      
      protected function InitializationActivitys() : void
      {
         this.FUIShortcut.SetFunctionByIndex(this.ActivitySecondaryOnClick,TYPE_Activity_NarutoRoad);
         this.FUIShortcut.SetFunctionByIndex(this.ActivitySecondaryOnClick,TYPE_Activity_Slave);
         this.FUIShortcut.SetFunctionByIndex(this.ActivitySecondaryOnClick,TYPE_Activity_SevenKing);
         this.FUIShortcut.SetFunctionByIndex(this.ActivitySecondaryOnClick,TYPE_Activity_CrossServerWar);
         this.FUIShortcut.SetFunctionByIndex(this.ActivitySecondaryOnClick,TYPE_Activity_SubmitBug);
         this.FUIShortcut.SetFunctionByIndex(this.ActivitySecondaryOnClick,TYPE_Activity_Magic);
         this.FUIShortcut.SetFunctionByIndex(this.ActivitySecondaryOnClick,TYPE_Activity_Moutain);
         this.FUIShortcut.SetFunctionByIndex(this.ActivitySecondaryOnClick,TYPE_Activity_Tower);
         this.FUIShortcut.SetFunctionByIndex(this.ActivitySecondaryOnClick,TYPE_Activity_DailyWelfare);
         this.FUIShortcut.SetFunctionByIndex(this.ActivitySecondaryOnClick,TYPE_Activity_Palace);
         this.FUIShortcut.SetFunctionByIndex(this.ActivitySecondaryOnClick,TYPE_Activity_NijiaStar);
         this.FUIShortcut.SetFunctionByIndex(this.ActivitySecondaryOnClick,TYPE_Activity_Ramen);
         this.FUIShortcut.SetFunctionByIndex(this.ActivitySecondaryOnClick,TYPE_Activity_TopOrganization);
         this.FUIShortcut.SetFunctionByIndex(this.ActivitySecondaryOnClick,TYPE_Activity_GroupBattle);
         this.FUIShortcut.SetFunctionByIndex(this.ActivitySecondaryOnClick,TYPE_Activity_Laboratory);
         this.FUIShortcut.SetFunctionByIndex(this.ActivitySecondaryOnClick,TYPE_Activity_SixFairy);
         this.FUIShortcut.SetFunctionByIndex(this.ActivitySecondaryOnClick,TYPE_Activity_RebirthRealm);
         this.FUIShortcut.SetFunctionByIndex(this.ActivitySecondaryOnClick,TYPE_Activity_NijiaMystic);
         this.FUIShortcut.SetFunctionByIndex(this.ActivitySecondaryOnClick,TYPE_Activity_TopTeam);
         this.FUIShortcut.SetFunctionByIndex(this.ActivitySecondaryOnClick,TYPE_Activity_NarutoHelper);
         this.FUIShortcut.SetFunctionByIndex(this.ActivitySecondaryOnClick,TYPE_Activity_Choose);
         this.FUIShortcut.SetFunctionByIndex(this.ActivitySecondaryOnClick,TYPE_Activity_NinjaRelation);
         this.FUIShortcut.SetFunctionByIndex(this.ActivitySecondaryOnClick,TYPE_Activity_NinjaHostel);
         this.FUIShortcut.SetFunctionByIndex(this.ActivitySecondaryOnClick,TYPE_Activity_BloodFete);
         this.FUIShortcut.SetFunctionByIndex(this.ActivitySecondaryOnClick,TYPE_Activity_EpicEquip);
         this.FUIShortcut.SetFunctionByIndex(this.ActivitySecondaryOnClick,TYPE_Activity_Taboo);
         this.FUIShortcut.SetFunctionByIndex(this.ActivitySecondaryOnClick,TYPE_Activity_Awaken);
         this.FUIShortcut.SetFunctionByIndex(this.ActivitySecondaryOnClick,TYPE_Activity_TransmigrationAccessory);
         this.FUIShortcut.SetFunctionByIndex(this.ActivitySecondaryOnClick,TYPE_Activity_EightDoor);
         this.FUIShortcut.SetFunctionByIndex(this.ActivitySecondaryOnClick,TYPE_Activity_TheWorldTree);
         this.FUIShortcut.SetFunctionByIndex(this.ActivitySecondaryOnClick,TYPE_Activity_Undertown);
         this.FUIShortcut.SetFunctionByIndex(this.ActivitySecondaryOnClick,TYPE_Activity_LostShenQi);
         this.FUIShortcut.SetFunctionByIndex(this.ActivitySecondaryOnClick,TYPE_Activity_Wing);
         this.FUIShortcut.SetFunctionByIndex(this.ActivitySecondaryOnClick,TYPE_Activity_Challenge);
         this.FUIShortcut.SetFunctionByIndex(this.ActivitySecondaryOnClick,TYPE_Activity_Illustrated);
         this.FUIShortcut.SetFunctionByIndex(this.ActivitySecondaryOnClick,TYPE_Activity_Aline);
         this.FUIShortcut.SetFunctionByIndex(this.ActivitySecondaryOnClick,TYPE_Activity_KingWar);
         this.FUIShortcut.SetFunctionByIndex(this.ActivitySecondaryOnClick,TYPE_Activity_Medal);
         this.FUIShortcut.SetFunctionByIndex(this.ActivitySecondaryOnClick,TYPE_Activity_InviteCode);
         this.FUIShortcut.SetFunctionByIndex(this.ActivitySecondaryOnClick,TYPE_Activity_Wuxing);
         this.FUIShortcut.SetFunctionByIndex(this.ActivitySecondaryOnClick,TYPE_Activity_GlobalBattle);
         this.FUIShortcut.SetFunctionByIndex(this.ActivitySecondaryOnClick,TYPE_Activity_Emblem);
         this.FUIShortcut.SetFunctionByIndex(this.ActivitySecondaryOnClick,TYPE_Activity_WorldMatch);
         this.FUIShortcut.SetFunctionByIndex(this.ActivitySecondaryOnClick,TYPE_Activity_SummonBattle);
         this.FUIShortcut.SetFunctionByIndex(this.ActivitySecondaryOnClick,TYPE_Activity_NinjaTalent);
         this.FUIShortcut.SetFunctionByIndex(this.ActivitySecondaryOnClick,TYPE_Activity_ChallengCamp);
         this.FUIShortcut.SetFunctionByIndex(this.ActivitySecondaryOnClick,TYPE_Activity_GlobalBoss);
         this.FUIShortcut.SetFunctionByIndex(this.ActivitySecondaryOnClick,TYPE_Activity_Recruit);
         this.FUIShortcut.SetFunctionByIndex(this.ActivitySecondaryOnClick,TYPE_Activity_CrossSlave);
      }
      
      protected function UpdateRestActivityState(param1:Vector.<Boolean>, param2:Vector.<Boolean>, param3:int) : void
      {
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:SimpleButton = null;
         var _loc7_:Boolean = false;
         var _loc8_:Boolean = false;
         var _loc9_:int = 0;
         var _loc10_:uint = 0;
         var _loc11_:int = 0;
         if(!this.FIsInitialization)
         {
            return;
         }
         if(!this.FUIShortcut.IsInitSecodary)
         {
            return;
         }
         _loc5_ = this.FUIShortcut.Capacity;
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc6_ = this.FUIShortcut.GetButtonByIndex(_loc4_);
            _loc6_.visible = false;
            _loc4_++;
         }
         _loc5_ = this.FUIShortcut.Capacity;
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc11_ = _loc4_ + param3;
            if(_loc11_ - CONST_SHORTCUTS.TARGET_Index - 1 >= _loc5_)
            {
               break;
            }
            _loc8_ = param2[_loc11_];
            _loc7_ = param1[_loc11_];
            if(!(!_loc8_ || !_loc7_))
            {
               _loc6_ = this.FUIShortcut.GetButtonByIndex(_loc11_ - CONST_SHORTCUTS.TARGET_Index - 1);
               _loc6_.visible = _loc8_ && _loc7_;
            }
            _loc4_++;
         }
         this.UpdateActivityShortcuts();
      }
      
      protected function UpdateActivityShortcuts() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Bitmap = null;
         var _loc4_:SimpleButton = null;
         var _loc5_:Boolean = false;
         var _loc6_:Boolean = false;
         _loc2_ = int(this.FUIShortcut.Capacity);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = this.FUIShortcut.GetButtonByIndex(_loc1_);
            _loc6_ = _loc4_.visible;
            if(this.FIsEffects != null)
            {
               _loc5_ = this.FIsEffects[_loc1_ + CONST_SHORTCUTS.TARGET_Index + 1];
            }
            if(!_loc6_)
            {
               this.FUIShortcut.SetIsEffectByIndex(_loc6_,_loc1_);
            }
            else
            {
               this.FUIShortcut.SetIsEffectByIndex(_loc5_,_loc1_);
            }
            _loc1_++;
         }
         this.FUIShortcut.ReplaceShortcutsLocation(this);
      }
      
      protected function ComponentsAlign() : void
      {
         if(!this.Visible)
         {
            return;
         }
         this.FBmp_Pointer.x = (this.ShortcutWidth - this.FBmp_Pointer.width - 10) / 2;
         this.FBmp_Pointer.y = this.FUIShortcut.Y - this.FBmp_Pointer.height + 2;
      }
      
      protected function UpdateShortcutEffect() : void
      {
         if(this.FIsInitialization)
         {
            this.FUIShortcut.UpdataEffect();
         }
      }
      
      protected function ProcessorShortcutShowEffect(param1:uint, param2:Boolean) : void
      {
         var _loc3_:SimpleButton = null;
         var _loc4_:Boolean = false;
         _loc3_ = this.FUIShortcut.GetButtonByIndex(param1);
         if(!_loc3_ || !_loc3_.visible)
         {
            if(param1 == TYPE_Activity_DailyWelfare)
            {
               _loc4_ = this.FUIShortcut.GetIsEffectByIndex(param1);
               this.FUIShortcut.SetIsEffectByIndex(_loc4_,param1);
            }
            return;
         }
         _loc4_ = this.FUIShortcut.GetIsEffectByIndex(param1);
         if(_loc4_ != param2)
         {
            this.FUIShortcut.SetIsEffectByIndex(param2,param1);
         }
      }
      
      protected function ActivitySecondaryOnClick(param1:Object, param2:int) : void
      {
         var _loc3_:uint = 0;
         if(param2 == TYPE_Activity_Magic)
         {
            _loc3_ = 0;
         }
         else if(param2 == TYPE_Activity_Moutain)
         {
            _loc3_ = 1;
         }
         this.FStreamParameter.length = 0;
         this.FStreamParameter.writeInt(_loc3_);
         this.FStreamParameter.position = 0;
         if(this.FOnActivitySecondary != null)
         {
            this.FOnActivitySecondary(this,param2 + CONST_SHORTCUTS.TARGET_Index + 1,this.FStreamParameter);
         }
         this.Hide();
      }
      
      protected function PerformTweenOperOnStart(param1:TweenEvent) : void
      {
         if(!this.Visible)
         {
            this.Visible = true;
         }
      }
      
      protected function PerformTweenOperOnComplete(param1:TweenEvent) : void
      {
         if(this.Visible)
         {
            this.Visible = false;
         }
      }
      
      public function get ShortcutWidth() : int
      {
         return this.FUIShortcut.Bounds.Width;
      }
      
      public function get OnActivitySecondary() : Function
      {
         return this.FOnActivitySecondary;
      }
      
      public function set OnActivitySecondary(param1:Function) : void
      {
         this.FOnActivitySecondary = param1;
      }
      
      public function Perform_UIDispatch() : void
      {
         this.Resources_UIDispatch();
         this.Resources_UILocations();
         this.FIsInitialization = true;
      }
      
      public function Show() : void
      {
         this.PerformTweenOperOnStart(null);
      }
      
      public function Hide() : void
      {
         this.PerformTweenOperOnComplete(null);
      }
      
      public function Update() : void
      {
         this.ComponentsAlign();
         this.UpdateShortcutEffect();
      }
      
      public function UpdateShortcutsState(param1:Vector.<Boolean>, param2:Vector.<Boolean>, param3:int) : void
      {
         this.UpdateRestActivityState(param1,param2,param3);
      }
      
      public function ShortcutsSetup(param1:TLobbyShortcutActivityModes, param2:Vector.<Boolean>, param3:Vector.<Boolean>, param4:Vector.<Boolean>, param5:int) : void
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:Boolean = false;
         var _loc9_:uint = 0;
         var _loc10_:SimpleButton = null;
         var _loc11_:Boolean = false;
         var _loc12_:Boolean = false;
         var _loc13_:int = 0;
         this.FIsEffects = param3;
         this.FTargetIndex = param5;
         if(!this.FIsInitialization)
         {
            return;
         }
         if(!this.FUIShortcut.IsInitSecodary)
         {
            return;
         }
         _loc6_ = int(this.FUIShortcut.Capacity);
         _loc7_ = 0;
         while(_loc7_ < _loc6_)
         {
            _loc13_ = _loc7_ + param5;
            if(_loc13_ - CONST_SHORTCUTS.TARGET_Index - 1 >= _loc6_)
            {
               break;
            }
            _loc9_ = param1.GetShortcutModeByIndex(_loc13_);
            _loc10_ = this.FUIShortcut.GetButtonByIndex(_loc13_ - CONST_SHORTCUTS.TARGET_Index - 1);
            switch(_loc9_)
            {
               case TLobbyShortcutMode.SHORTCUTMODE_Show:
                  _loc11_ = true;
                  break;
               case TLobbyShortcutMode.SHORTCUTMODE_Hidden:
                  _loc11_ = false;
            }
            _loc12_ = param4[_loc13_];
            _loc8_ = param2[_loc13_];
            if(!_loc12_)
            {
               _loc11_ = _loc12_;
            }
            if(!_loc8_)
            {
               _loc11_ = _loc8_;
            }
            _loc10_.visible = _loc11_;
            _loc7_++;
         }
         this.UpdateActivityShortcuts();
      }
      
      public function ShowEffectNotification(param1:uint, param2:Boolean) : void
      {
         this.ProcessorShortcutShowEffect(param1 - (CONST_SHORTCUTS.TARGET_Index + 1),param2);
      }
      
      public function GetButtonVisibleStatus(param1:uint) : Boolean
      {
         var _loc2_:SimpleButton = null;
         _loc2_ = this.FUIShortcut.GetButtonByIndex(param1);
         return _loc2_.visible;
      }
      
      public function SetEffects(param1:Vector.<Boolean>) : void
      {
         this.FIsEffects = param1;
      }
   }
}

